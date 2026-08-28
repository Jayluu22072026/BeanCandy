//
//  CustomTabView.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 23/08/26.
//

import SwiftUI

struct CustomTabView: View {
    @State var selectedIndex: Int = 0
    var body: some View {
        TabView(selection: $selectedIndex) {
            Tab("Flavors", systemImage: "house", value: 0) {
                NavigationStack{
                    FlavoursView()
                }
            }
            
            Tab("Combo", systemImage: "square.grid.2x2", value: 1) {
                ComboView()
            }
            
            Tab("Recipes", systemImage: "book", value: 2) {
                RecipesView()
            }
            
            Tab("Facts", systemImage: "lightbulb", value: 3) {
                FactsView()
            }
            
            Tab("Profile", systemImage: "person", value: 4) {
                ProfileView()
            }
        }
    }
}

#Preview {
    CustomTabView()
}
