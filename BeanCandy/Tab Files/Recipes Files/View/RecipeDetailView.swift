//
//  RecipeDetailView.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 02/09/26.
//

import SwiftUI

struct RecipeDetailView : View {
    @Environment(\.colorScheme) var colorScheme
    var recipeVM : RecipesViewModel
    var beansVM : BeansViewModel
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? Color.c_12100F : Color.c_F2EDE4).ignoresSafeArea()
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    jellyImage
                    
                    jellyName
                    
                    jellyInfo
                    
                    jellyIngred
                    
                    jellyStep
                }
            }
            .scrollIndicators(.hidden)
            .padding()
        }
    }
}

// MARK: Logic
extension RecipeDetailView {
    
}

// MARK: View
extension RecipeDetailView {
    var jellyImage: some View {
        RoundedRectangle(cornerRadius: 18)
            .fill(.blue.opacity(0.4))
            .frame(height: 200)
            .overlay {
                ZStack {
                    Group {
                        Ellipse()
                            .fill(Color.blue)
                            .frame(width: 67, height: 47)
                        Ellipse()
                            .fill(.white.opacity(0.7))
                            .frame(width: 15, height: 7)
                            .padding(.bottom, 10)
                    }
                    .rotationEffect(Angle(degrees: -35))
                }
            }
    }
    
    var jellyName : some View {
        Text("Jelly Name")
            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
            .fontWeight(.bold)
            .font(.system(size: 28))
    }
    
    var jellyInfo: some View {
        Text("Time to prep • servings count")
            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.5) : Color.c_1C1418.opacity(0.45))
            .font(.system(size: 16))
    }
    
    var jellyIngred : some View {
        Group {
            Text("INGREDIENTS")
                .fontWeight(.semibold)
                .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.45) : Color.c_1C1418.opacity(0.5))
            
            VStack(alignment: .leading) {
                Text("I1")
                Divider()
                Text("I2")
                Divider()
                Text("I3")
                Divider()
                Text("I4")
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 18)
                    .fill(colorScheme == .dark ? Color.c_1E1B19 : Color.c_FFFFFF)
            }
        }
    }
    
    var jellyStep : some View {
        Group {
            Text("STEPS")
                .fontWeight(.semibold)
                .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.45) : Color.c_1C1418.opacity(0.5))
            HStack{
                Text("1")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.c_FFFFFF)
                    .padding(10)
                    .background {
                        Circle()
                            .fill(colorScheme == .dark ? Color.c_FF6B6F : Color.c_E0343C)
                    }
                
                Text("Step Details")
                    .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.8) : Color.c_1C1418.opacity(0.78))
            }
            .padding(.vertical, 4)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(colorScheme == .dark ? Color.c_1E1B19 : Color.c_FFFFFF)
            }
        }
    }
}

#Preview {
    RecipeDetailView(recipeVM: RecipesViewModel(), beansVM: BeansViewModel())
}
