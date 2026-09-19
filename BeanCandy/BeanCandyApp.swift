//
//  BeanCandyApp.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 22/08/26.
//

import SwiftUI
import Firebase

@main
struct BeanCandyApp: App {
    @State private var auth : AuthenticationManager
    init() {
        // Configure Firebase FIRST, before anything touches Auth.auth().
        FirebaseApp.configure()
        // Now it's safe to create the manager (which attaches the listener).
        // _auth is the backing store for the @State property — this is how
        // you assign a @State value from inside init().
        _auth = State(initialValue: AuthenticationManager())
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                OnboardingView()
            }
            .environment(auth)
        }
    }
}
