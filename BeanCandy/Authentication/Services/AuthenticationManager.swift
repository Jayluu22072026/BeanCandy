//
//  AuthenticationManager.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 13/09/26.
//

import SwiftUI
import FirebaseAuth

@Observable
final class AuthenticationManager {
    /// the current signed-in user or nil if a guest
    var user: UserAuth?
    
    var isLoading = false
    /// custom error to show the user what kind of error they might have faced
    var error: AuthError?
    
    /// we write this because with this we can use it in the code like this `if auth.isAuthenticated`
    /// instead of writing `if auth.user != nil` everywhere.
    var isAuthenticated: Bool { user != nil }
    
    /// Firebase hands us a "handle" when we start listening. We keep it
    /// so we can stop listening later (in deinit) and avoid a leak.
    private var listenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        /// Start listening the moment this object is created (app launch).
        /// This is what restores a previously-saved session automatically.
        startListening()
    }
    
    deinit {
        /// Clean up: detach the listener when this object is destroyed,
        /// so Firebase isn't calling a closure that points to freed memory.
        if let listenerHandle {
            Auth.auth().removeStateDidChangeListener(listenerHandle)
        }
    }
    
    // MARK: - Session persistence

    /// We DON'T manually save or load the user anywhere. Firebase already
    /// cached the session in the Keychain when the user signed in. Here we
    /// just subscribe to auth changes, and Firebase pushes us the result:
    ///   • once at launch  → the restored user (or nil)
    ///   • on every sign-in → the new user
    ///   • on every sign-out → nil
    ///
    /// This is why this class never has to ask "is someone logged in?" —
    /// it gets told.
    private func startListening() {
        listenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, firebaseUser in
            // [weak self] avoids a retain cycle: the closure lives inside
            // Firebase, so if it held a strong reference to us we'd never
            // be freed.

            if let firebaseUser {
                // Firebase gives a big User object. We map only the fields
                // we care about into our own small AuthUser, so Firebase's
                // type doesn't leak through the entire app.
                self?.user = UserAuth(user: firebaseUser)
            } else {
                // No user → logged out.
                self?.user = nil
            }
        }
    }
    
    // MARK: - Sign out
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            /// Notice we do NOT write `user = nil` here. Signing out changes
            /// Firebase's auth state, which fires the listener above, which
            /// sets user = nil for us. One source of truth — no double-setting.
        } catch {
            self.error = .firebase(error.localizedDescription)
        }
    }
}
