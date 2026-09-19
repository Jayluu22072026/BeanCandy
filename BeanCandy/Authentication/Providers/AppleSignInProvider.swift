//
//  AppleSignInProvider.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 17/09/26.
//

import Foundation
import AuthenticationServices   // Apple's sign-in UI + credential types
import FirebaseAuth             // to build the Firebase credential
import CryptoKit                // (used indirectly via NonceHelper)

// This class does ONE job: run the Apple sign-in flow and return a
// signed-in Firebase user. It's a class (not struct) because Apple's
// ASAuthorizationController requires a delegate object that stays alive
// during the flow — a struct can't be a delegate.
//
// It inherits NSObject because the two Apple protocols below are
// Objective-C protocols and require an NSObject-based class.
final class AppleSignInProvider: NSObject {

    // We stash the ORIGINAL nonce here so it survives from "start the flow"
    // until Apple calls us back. We need it at the very end for Firebase.
    private var currentNonce: String?

    // A continuation is the bridge between Apple's old callback style and
    // modern async/await. We hold onto it, and when Apple calls our
    // delegate method, we "resume" it — which makes the awaited call return.
    private var continuation: CheckedContinuation<UserAuth, Error>?

    // The single public entry point. SigninView will just `await` this.
    func signIn() async throws -> UserAuth {
        // 1. Make a fresh nonce for THIS sign-in attempt.
        let nonce = NonceHelper.randomNonceString()
        currentNonce = nonce

        // 2. Build Apple's request. We ask for name + email, and send the
        //    HASHED nonce (never the original) to Apple.
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = NonceHelper.sha256(nonce)

        // 3. Wrap Apple's callback flow in a continuation so callers can await.
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation

            let controller = ASAuthorizationController(authorizationRequests: [request])
            controller.delegate = self                    // "call me back on the methods below"
            controller.presentationContextProvider = self // "here's the window to show the sheet over"
            controller.performRequests()                  // actually launches the Apple sheet
        }
    }
}

// MARK: - Delegate: Apple calls these when the flow finishes
extension AppleSignInProvider: ASAuthorizationControllerDelegate {

    // SUCCESS path — Apple authenticated the user.
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        // Pull the Apple credential out of the result.
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let nonce = currentNonce,                          // the original we stashed
              let appleIDToken = appleIDCredential.identityToken, // the token Apple signed
              let idTokenString = String(data: appleIDToken, encoding: .utf8)
        else {
            // Something we needed was missing — fail the awaited call.
            continuation?.resume(throwing: AuthError.failLogin)
            continuation = nil
            return
        }

        // Build a Firebase credential from Apple's token + our original nonce.
        // Firebase re-hashes the nonce and checks it against the token.
        let credential = OAuthProvider.appleCredential(
            withIDToken: idTokenString,
            rawNonce: nonce,
            fullName: appleIDCredential.fullName
        )

        // Sign in to Firebase with that credential. This is async, so we
        // jump into a Task to await it inside this non-async delegate method.
        Task {
            do {
                let result = try await Auth.auth().signIn(with: credential)
                // Success → hand the mapped user back through the continuation.
                self.continuation?.resume(returning: UserAuth(user: result.user))
            } catch {
                self.continuation?.resume(throwing: AuthError.firebase(error.localizedDescription))
            }
            self.continuation = nil
        }
    }

    // FAILURE path — user cancelled, or something errored.
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        continuation?.resume(throwing: AuthError.failLogin)
        continuation = nil
    }
}

// MARK: - Presentation: tells Apple which window to show the sheet over
extension AppleSignInProvider: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // Grab the app's active window. Apple anchors its sheet to this.
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.first ?? ASPresentationAnchor()
    }
}
