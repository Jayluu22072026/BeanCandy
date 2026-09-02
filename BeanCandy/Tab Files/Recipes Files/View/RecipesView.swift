//
//  RecipesView.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 23/08/26.
//

import SwiftUI

struct RecipesView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(RecipesViewModel.self) var recipeVM
    @Environment(BeansViewModel.self) var beansVM
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? Color.c_12100F : Color.c_F2EDE4).ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    recipesTitle
                    
                    recipesGridView
                }
            }
            .scrollIndicators(.hidden)
            .padding()
        }
    }
}

extension RecipesView {
    var recipesTitle : some View {
        Text("Recipes")
            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
            .font(.system(size: 34))
            .fontWeight(.bold)
    }
    
    var recipesGridView: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
            ForEach(0...10, id: \.self) { _ in
                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(.blue.opacity(0.4))
                        .frame(height: 150)
                        .overlay {
                            ZStack {
                                Group {
                                    Ellipse()
                                        .fill(Color.red)
                                        .frame(width: 32, height: 20)
                                    Ellipse()
                                        .fill(.white.opacity(0.7))
                                        .frame(width: 10, height: 5)
                                        .padding(.bottom, 10)
                                }
                                .rotationEffect(Angle(degrees: -35))
                            }
                        }
                    Text("Candy name")
                        .fontWeight(.semibold)
                        .font(.system(size: 18))
                        .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
                    Text("Time to prep • servings count")
                        .font(.system(size: 14))
                        .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.5) : Color.c_1C1418.opacity(0.45))
                }
            }
        }
    }
}

#Preview {
    RecipesView()
        .environment(RecipesViewModel())
        .environment(BeansViewModel())
}
