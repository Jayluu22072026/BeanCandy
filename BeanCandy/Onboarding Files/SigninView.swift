//
//  SigninView.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 22/08/26.
//

import SwiftUI

struct SigninView : View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(AuthenticationManager.self) var auth
    @State private var appleProvider = AppleSignInProvider()
    @State private var googleProvider = GoogleSignInProvider()
    @State var completeOnboarding: Bool = false
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? Color.c_12100F : Color.c_F2EDE4).ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                welcomingText
                
                Spacer()
                
                buttonArrangementView
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $completeOnboarding) {
            CustomTabView()
        }
    }
}

// MARK: Views
extension SigninView {
    var welcomingText: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading,spacing: 0) {
                Text("Welcome to")
                    
                Text("BeanBook")
            }
            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
            .font(.title)
            .fontWeight(.heavy)
            Text("Sign in to sync your favourites and tasting notes across devices.")
                .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.66) : Color.c_1C1418.opacity(0.6))
        }
    }
    
    var buttonArrangementView: some View {
        VStack(spacing: 12) {
            appleButton
            
            googleButton
            
            guestButton
        }
    }
    
    var appleButton: some View {
        Button {
            appleButtonLogic()
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .fill(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_000000)
                .frame(height: 50)
                .overlay {
                    HStack {
                        Image(systemName: "apple.logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text("Signin with apple")
                    }
                    .foregroundStyle(colorScheme == .dark ? Color.c_12100F : Color.c_FFFFFF)
                    
                }
        }
    }
    
    var googleButton: some View {
        Button {
            googleButtonLogic()
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .fill(colorScheme == .dark ? Color.c_1E1B19 : Color.c_FFFFFF)
                .stroke(colorScheme == .dark ? Color.c_FDF6EC.opacity(0.14) : Color.c_1C1418.opacity(0.12), lineWidth: 2)
                .frame(height: 50)
                .overlay {
                    HStack {
                        Image("GoogleIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text("Signin with apple")
                            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
                    }
                }
        }
    }
    
    var guestButton: some View {
        Button {
            guestButtonLogic()
        } label: {
            Text("Browse as guest")
                .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.5) : Color.c_1C1418.opacity(0.45))
                .font(.headline)
        }
    }
}

// MARK: Logic
extension SigninView {
    func appleButtonLogic() {
        Task {
            do {
                // Run the whole Apple flow. On success this returns a UserAuth,
                // AND Firebase's state listener in AuthenticationManager has
                // already fired — so auth.user is set too.
                _ = try await appleProvider.signIn()
                // Sign-in worked → move into the app.
                completeOnboarding = true
            } catch AuthError.failLogin {
                // User cancelled or Apple failed — do nothing, stay on screen.
            } catch {
                // Any other error → surface it via the manager for an alert later.
                auth.error = .firebase(error.localizedDescription)
            }
        }
    }
    
    func googleButtonLogic() {
        Task {
            do {
                _ = try await googleProvider.signIn()
                completeOnboarding = true
            } catch AuthError.failLogin {
                // User cancelled — stay on screen.
            } catch {
                auth.error = .firebase(error.localizedDescription)
            }
        }
    }
    
    func guestButtonLogic() {
        completeOnboarding = true
    }
}

#Preview {
    SigninView()
        .environment(AuthenticationManager())
}
