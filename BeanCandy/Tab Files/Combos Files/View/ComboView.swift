//
//  ComboView.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 23/08/26.
//

import SwiftUI

struct ComboView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? Color.c_12100F : Color.c_F2EDE4).ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Flavours")
                        .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                    Text("Two beans, one new flavour. Tap a card for the mixing ratio.")
                        .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.8) : Color.c_1C1418.opacity(0.78))
                        .font(.system(size: 18))
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(0..<10, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 18)
                                .fill(colorScheme == .dark ? Color.c_1E1B19 : Color.c_FFFFFF)
                                .frame(height: 150)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

extension ComboView {
    
}

#Preview {
    ComboView()
}
