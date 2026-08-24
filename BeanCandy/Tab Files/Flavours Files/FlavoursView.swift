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
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? Color.c_12100F : Color.c_F2EDE4).ignoresSafeArea()
            ScrollView{
                VStack {
                    Text("Flavours")
                        .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    searchBarView
                    
                    filterChipsView
                    
                    List {
                        Section(header: Text("Chip wise Flavour")) {
                            individualListView
                            individualListView
                            individualListView
                        }
                    }
                    
                }
            }
            .scrollIndicators(.hidden)
        }
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
        ScrollView(.horizontal) {
            HStack{
                filterChip(chipName: "unSelected")
                filterChipSelected(chipName: "Selected")
            }
        }
    }
    
    var individualListView : some View {
        HStack {
            Image(systemName: "ellipse")
                .foregroundStyle(.red)
            
            VStack(alignment: .leading) {
                Text("Cherry Name")
                Text("Cherry Section Name")
            }
            
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
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
    
}

#Preview {
//    FlavoursView()
    CustomTabView()
}

