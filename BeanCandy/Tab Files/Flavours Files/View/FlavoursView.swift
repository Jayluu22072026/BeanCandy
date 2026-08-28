//
//  HomeView.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 23/08/26.
//

import SwiftUI

struct FlavoursView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var searchText: String = ""
    var chipArrays : [String] = [
        "All",
        "Favourites",
        "Fruit",
        "Citrus",
        "Sweet",
        "Spice",
        "Soda"
    ]
    var fruitArray: [String] = [
        "Very Cherry",
        "Juicy Pear",
        "Blueberry",
        "Green Apple",
        "Watermelon",
        "Berry Blue",
        "Top Banana"
    ]
    var citrusArray: [String] = [
        "Tangerine",
        "Lemon Drop"
    ]
    var sweetArray: [String] = [
        "Buttered Popcorn",
        "Toasted Marshmallow",
        "Coconut",
        "Cotton Candy"
    ]
    
    var spiceArray: [String] = [
        "Sizzling Cinnamon",
        "Licorice"
    ]
    var sodaArray: [String] = [
        "Root Beer"
    ]
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? Color.c_12100F : Color.c_F2EDE4).ignoresSafeArea()
            ScrollView{
                VStack(alignment: .leading) {
                    flavourTitle
                    
                    searchBarView
                    
                    filterChipsView
                    
                    sectionListView(cherryColor: .red, cherryName: "test", sectionName: "test section")
                    
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
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
    
    var filterChipsView: some View {
        /*
        ScrollView(.horizontal) {
            HStack{
                filterChip(chipName: "unSelected")
                filterChipSelected(chipName: "Selected")
            }
        }
        */
        
        ScrollView(.horizontal){
            HStack {
                ForEach(chipArrays, id: \.self) { value in
                    filterChip(chipName: value)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
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
    
    func sectionListView(
        cherryColor: Color,
        cherryName: String,
        sectionName: String
    ) -> some View {
        Group {
            Text("\(sectionName)".uppercased())
                .font(.system(size: 13))
                .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.5) : Color.c_1C1418.opacity(0.45))
            
            VStack {
                individualListDetails(jellyColor: cherryColor, cherryName: cherryName, cherrySectionName: sectionName)
                Divider()
                    .background {
                        colorScheme == .dark ? Color.c_F7F1E8.opacity(0.1) : Color.c_1C1418.opacity(0.09)
                    }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(colorScheme == .dark ? Color.c_1E1B19 : Color.c_FFFFFF)
            }
        }
    }
    
    func individualListDetails(
        jellyColor: Color,
        cherryName: String,
        cherrySectionName: String
    ) -> some View {
        HStack {
            jellyView(jellyColor: jellyColor)
            
            VStack(alignment: .leading) {
                Text(cherryName)
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
    
    func jellyView(jellyColor: Color) ->  some View {
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
    }
    
}

extension FlavoursView {
    
}

#Preview {
//    FlavoursView()
    CustomTabView()
}

