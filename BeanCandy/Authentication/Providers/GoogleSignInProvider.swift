//
//  GoogleSignInProvider.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 17/09/26.
//

import Foundation
import FirebaseAuth
import FirebaseCore      // for FirebaseApp.app()?.options.clientID
import GoogleSignIn      // the SDK you added
import UIKit             // for finding the root view controller

// Runs the Google sign-in flow and returns a Firebase-backed UserAuth.
// Much shorter than Apple's provider: GoogleSignIn's SDK is already
// async/await, so there's no continuation or delegate to wrap, and no
// nonce (the SDK handles replay protection for us).
final class GoogleSignInProvider {

    func signIn() async throws -> UserAuth {
        // 1. Firebase's clientID (from GoogleService-Info.plist) tells the
        //    Google SDK which OAuth client this app is. Without it, no flow.
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw AuthError.failLogin
        }
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)

        // 2. Google needs a view controller to present its sheet over —
        //    the same "which window?" problem Apple had, solved differently.
        guard let rootViewController = Self.rootViewController() else {
            throw AuthError.failLogin
        }

        // 3. Present the Google sheet and wait for the user. This is the
        //    SDK's own async call — no continuation wrapping needed.
        let result = try await GIDSignIn.sharedInstance.signIn(
            withPresenting: rootViewController
        )

        // 4. Pull the two tokens Firebase needs out of the Google result.
        let googleUser = result.user
        guard let idToken = googleUser.idToken?.tokenString else {
            throw AuthError.failLogin
        }
        let accessToken = googleUser.accessToken.tokenString

        // 5. Build a Firebase credential from Google's tokens.
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: accessToken
        )

        // 6. Sign in to Firebase → the listener in AuthenticationManager
        //    fires and sets auth.user. We also return the mapped user.
        let authResult = try await Auth.auth().signIn(with: credential)
        return UserAuth(user: authResult.user)
    }

    // Finds the top-most view controller to present the Google sheet from.
    // Same idea as Apple's presentationAnchor, just returns a VC instead.
    private static func rootViewController() -> UIViewController? {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.first?.rootViewController
    }
}
