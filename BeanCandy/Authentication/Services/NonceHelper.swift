//
//  NonceHelper.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 19/09/26.
//


import Foundation
import CryptoKit   // Apple's crypto library — gives us SHA256

/// This whole file exists for ONE reason: Sign in with Apple's
/// replay-attack guard. We send Apple a HASHED nonce, then later prove
/// to Firebase we knew the ORIGINAL. See the two functions below.
///
/// You will basically never edit this file. Apple publishes this code
/// almost verbatim in their docs — it's boilerplate, not your logic.
enum NonceHelper {

    /// Generates a random string (the "nonce" = number-used-once).
    /// This is the ORIGINAL nonce. We `keep it in memory`, send Apple only
    /// its hash, and hand the original to Firebase at the end so Firebase
    /// can verify the two match.
    static func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        // These are the safe characters allowed in a nonce.
        let charset: [Character] =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            // Ask the system for cryptographically secure random bytes.
            // (Not Int.random — that's not secure enough for auth.)
            let randoms: [UInt8] = (0..<16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with \(errorCode)")
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 { return }
                // Only use the random byte if it maps to a valid character.
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }

    /// Hashes the nonce with SHA256. This `HASHED version is what we send
    /// `to Apple.` Apple bakes it into the identity token it returns.
    /// Later, Firebase re-hashes our original nonce and checks it matches
    /// what's inside the token — proving this sign-in is fresh, not a
    /// stolen/replayed token from before.
    static func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        // Convert the raw hash bytes into a hex string.
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        return hashString
    }
}
