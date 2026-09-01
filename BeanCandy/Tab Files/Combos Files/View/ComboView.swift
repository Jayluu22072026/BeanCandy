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
                    comboTitle
                    
                    comboDescription
                    
                    comboGridView
                }
            }
            .scrollIndicators(.hidden)
            .padding()
        }
    }
}

// MARK: Logic
extension ComboView {
    
}

// MARK: View
extension ComboView {
    var comboTitle : some View {
        Text("Combos")
            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
            .font(.system(size: 34))
            .fontWeight(.bold)
    }
    
    var comboDescription: some View {
        Text("Two beans, one new flavour. Tap a card for the mixing ratio.")
            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.8) : Color.c_1C1418.opacity(0.78))
            .font(.system(size: 18))
    }
    
    var comboGridView: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
            ForEach(0..<10, id: \.self) { _ in
                gridCellView
            }
        }
    }
    
    var gridCellView: some View {
        RoundedRectangle(cornerRadius: 18)
            .fill(colorScheme == .dark ? Color.c_1E1B19 : Color.c_FFFFFF)
            .frame(height: 150)
            .overlay {
                VStack(alignment: .leading) {
                    ZStack {
                            Group {
                                Ellipse()
                                    .fill(Color.red)
                                    .frame(width: 32, height: 20)
                                Ellipse()
                                    .fill(.white.opacity(0.7))
                                    .frame(width: 10, height: 5)
                                    .padding(.top, 20)
                                    
                            }
                            .rotationEffect(Angle(degrees: -35))
                            .offset(x: -10)
                            Group {
                                Ellipse()
                                    .fill(Color.blue)
                                    .frame(width: 32, height: 20)
                                Ellipse()
                                    .fill(.white.opacity(0.7))
                                    .frame(width: 10, height: 5)
                                    .padding(.bottom, 10)
                            }
                            .rotationEffect(Angle(degrees: 35))
                            .offset(x: 10)
                    }
                    
                    Text("Combo Name")
                    Text("Jelly1 + Jelly2")
                        .font(.system(size: 12))
                }
            }
    }
    
}
#Preview {
    ComboView()
}
