//
//  ProfileView.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 23/08/26.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.colorScheme) var colorScheme
    var colorSet : [Color] = [.red, .orange, .brown, .green, .teal, .blue, .indigo, .purple]
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? Color.c_12100F : Color.c_F2EDE4).ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    profileTitle
                    
                    userDetail
                    
                    
                }
            }
        }
    }
}

extension ProfileView {
    var profileTitle: some View {
        Text("Me")
            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
            .font(.system(size: 34))
            .fontWeight(.bold)
    }
    
    var userDetail: some View {
        HStack {
            Text("J")
                .padding(12)
                .background {
                    Circle()
                        .fill(colorSet.randomElement() ?? .white)
                }
            VStack(alignment: .leading) {
                Text("User Name")
                HStack {
                    Text("2 favourites")
                }
            }
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(colorScheme == .dark ? Color.c_1E1B19 : Color.c_FFFFFF)
        }
    }
    
    var appSettings: some View {
        Group {
            Text("SETTINGS")
            
            VStack {
                HStack {
                    Text("App Mode")
                    
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
