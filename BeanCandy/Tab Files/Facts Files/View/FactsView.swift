//
//  FactsView.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 23/08/26.
//

import SwiftUI

struct FactsView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? Color.c_12100F : Color.c_F2EDE4).ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    factsTitle
                    factInfo
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text("Ronald Reagan kept a jar of Jelly Belly beans on the Cabinet Room table — Blueberry was created so there would be a red, white and blue mix for the 1981 inauguration.")
                        Button {
                            
                        } label: {
                            HStack(spacing: 0){
                                Text("TAP FOR THE SOURCE ")
                                
                                Image(systemName: "arrow.right")
                            }
                            .foregroundStyle(.red) // color will change as per the card color
                            .font(.system(size: 12))
                        }
                    }
                        .padding()
                        .background {
                            ZStack {
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(.red)
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(colorScheme == .dark ? Color.c_1E1B19 : Color.c_FFFFFF)
                                    .padding(.leading, 6)
                            }
                        }
                    
                    
                }
            }
            .scrollIndicators(.hidden)
            .padding()
        }
    }
}

extension FactsView {
    var factsTitle : some View {
        Text("Facts")
            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
            .font(.system(size: 34))
            .fontWeight(.bold)
    }
    
    var factInfo: some View {
        Text("A pull-to-refresh feed of trivia from the API.")
            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.66) : Color.c_1C1418.opacity(0.6))
            .font(.system(size: 18))
    }
}

#Preview {
    FactsView()
}
