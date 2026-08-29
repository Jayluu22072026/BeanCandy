//
//  HomeView.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 23/08/26.
//

import SwiftUI

// now only thing left in this view is the list arrangement thinking

struct FlavourSection: Identifiable {
    var id = UUID()
    let category: String
    let flavours: [String] // we will make this into a dictionary once i have added the colors
}

struct FlavoursView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var searchText: String = ""
    
    // the all and favourites chips need to be added manually
    let sectionWiseFlavours: [FlavourSection] = [
        .init(category: "Fruit", flavours: [
            "Very Cherry",
            "Juicy Pear",
            "Blueberry",
            "Green Apple",
            "Watermelon",
            "Berry Blue",
            "Top Banana"
        ]),
        .init(category: "Citrus", flavours: [
            "Tangerine",
            "Lemon Drop"
        ]),
        .init(category: "Sweet", flavours: [
            "Buttered Popcorn",
            "Toasted Marshmallow",
            "Coconut",
            "Cotton Candy"
        ]),
        .init(category: "Spice", flavours: [
            "Sizzling Cinnamon",
            "Licorice"
        ]),
        .init(category: "Soda", flavours: [
            "Root Beer"
        ])
    ]
    
    /*
     if it is
     all = 16
     fav: onlt the fav ones
     fruit = 7
     citrus = 2
     sweet = 4
     spice = 2
     soda = 1
     */
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? Color.c_12100F : Color.c_F2EDE4).ignoresSafeArea()
            ScrollView{
                VStack(alignment: .leading) {
                    flavourTitle
                    
                    searchBarView
                    
                    filterChipsView
                                                             
                    ForEach(sectionWiseFlavours) { section in
                        
                        // i will first make the header
                        Text(section.category) 
                            .font(.system(size: 13))
                            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.5) : Color.c_1C1418.opacity(0.45))
                        /// now i need to work with the individual list part
                        HStack {
                            
                            
                            VStack(alignment: .leading) {
                                
                                ForEach(section.flavours, id: \.self) { individualFlavor in
                                    ZStack {
                                        Group {
                                            Ellipse()
                                                .fill(.red)
                                                .frame(width: 32, height: 20)
                                            Ellipse()
                                                .fill(.white.opacity(0.7))
                                                .frame(width: 10, height: 5)
                                                .padding(.bottom, 10)
                                        }
                                        .rotationEffect(Angle(degrees: -35))
                                    }
                                    
                                    Text(individualFlavor)
                                        .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
                                    Text(section.category)
                                        .font(.system(size: 12))
                                        .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.5) : Color.c_1C1418.opacity(0.45))
                                }
                            }
                            
                            Spacer()
                            
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                        }
                        
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

// MARK: Logic
extension FlavoursView {
    
}

// MARK: Variable Views
extension FlavoursView {
    var flavourTitle: some View {
        Text("Flavours")
            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
            .font(.system(size: 34))
            .fontWeight(.bold)
    }
    
    var searchBarView: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Search...", text: $searchText)
        }
        .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.5) : Color.c_1C1418.opacity(0.45))
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.09) : Color.c_1C1418.opacity(0.06))
        }
    }
    
    // UI completed, logic yet left out
    var filterChipsView: some View {
        ScrollView(.horizontal){
            HStack {
                filterChip(chipName: "All")
                filterChip(chipName: "Favourites")
                ForEach(sectionWiseFlavours) { value in
                    filterChip(chipName: value.category)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    var sectionTitleView: some View {
        ForEach(sectionWiseFlavours) { section in
            Text(section.category)
                .font(.system(size: 13))
                .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.5) : Color.c_1C1418.opacity(0.45))
        }
    }
}

// MARK: Function Views
extension FlavoursView {
    
    func filterChip(chipName: String) -> some View {
        Text("\(chipName)")
            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background {
                Capsule()
                    .fill(colorScheme == .dark ? Color.c_FDF6EC.opacity(0.09) : Color.c_1C1418.opacity(0.06))
            }
    }
    
    func filterChipSelected(chipName: String) -> some View {
        Text("\(chipName)")
            .foregroundStyle(colorScheme == .dark ? Color.c_1C1418 : Color.c_F7F1E8)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background {
                Capsule()
                    .fill(colorScheme == .dark ? Color.c_FDF6EC : Color.c_1C1418)
            }
    }
        
    func individualListDetails(
        jellyColor: Color,
        cherryName: [String],
        cherrySectionName: String
    ) -> some View {
        HStack {
            ZStack {
                Group {
                    Ellipse()
                        .fill(jellyColor)
                        .frame(width: 32, height: 20)
                    Ellipse()
                        .fill(.white.opacity(0.7))
                        .frame(width: 10, height: 5)
                        .padding(.bottom, 10)
                }
                .rotationEffect(Angle(degrees: -35))
            }
            
            VStack(alignment: .leading) {
                Text(cherryName.description)
                    .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
                Text(cherrySectionName)
                    .font(.system(size: 12))
                    .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.5) : Color.c_1C1418.opacity(0.45))
            }
            
            Spacer()
            
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
        }
    }
    
    // the left side jelly that we have view
//    func jellyView(jellyColor: Color) ->  some View {
//        
//    }
}

#Preview {
//    FlavoursView()
    CustomTabView()
}

