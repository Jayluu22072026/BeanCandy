//
//  HomeView.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 23/08/26.
//

import SwiftUI

struct FlavoursView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(BeansViewModel.self) var beansViewModel
    @State var searchText: String = ""
    
    let sectionWiseFlavours: [FlavourSection] = [
        .init(category: "Fruit", flavours: [
            "Very Cherry"   : Color.veryCherryJelly,
            "Juicy Pear"    : Color.juicyPearJelly,
            "Blueberry"     : Color.blueberryJelly,
            "Green Apple"   : Color.greenAppleJelly,
            "Watermelon"    : Color.watermelonJelly,
            "Berry Blue"    : Color.berryBlueJelly,
            "Top Banana"    : Color.topBananaJelly
        ]),
        .init(category: "Citrus", flavours: [
            "Tangerine"     : Color.tangerineJelly,
            "Lemon Drop"    : Color.lemonDropJelly
        ]),
        .init(category: "Sweet", flavours: [
            "Buttered Popcorn"      : Color.butteredPopcornJelly,
            "Toasted Marshmallow"   : Color.toastedMarshmellowJelly,
            "Coconut"               : Color.coconutJelly,
            "Cotton Candy"          : Color.cottonCandyJelly
        ]),
        .init(category: "Spice", flavours: [
            "Sizzling Cinnamon" :   Color.sizzlingCinnamonJelly,
            "Licorice"          :   Color.licoriceJelly
        ]),
        .init(category: "Soda", flavours: [
            "Root Beer" : Color.rootBeerJelly
        ])
    ]
        
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? Color.c_12100F : Color.c_F2EDE4).ignoresSafeArea()
            ScrollView{
                VStack(alignment: .leading) {
                    
                    flavourTitle
                    
                    searchBarView
                                                             
                    if beansViewModel.isLoading {
                        ProgressView()
                    } else if let errorMessage = beansViewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .font(.title)
                    } else {
                        listSectionView
                    }
                    
                }
            }
            .padding()
            .scrollIndicators(.hidden)
            .navigationBarBackButtonHidden()
        }
        .task {
            await beansViewModel.loadBeans()
        }
    }
}

// MARK: Logic
extension FlavoursView {
    
}

// MARK: Variable Views
extension FlavoursView {
    /// the Flavour title that we have
    /// we didnt use the `.navigationTitle` as the title also had to be scrollable
    var flavourTitle: some View {
        Text("Flavours")
            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
            .font(.system(size: 34))
            .fontWeight(.bold)
    }
    
    /// the ui is created only searching part logic is left for it
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
    
    /// every section header is put in here
    var sectionTitleView: some View {
        ForEach(sectionWiseFlavours) { section in
            Text(section.category)
                .font(.system(size: 13))
                .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.5) : Color.c_1C1418.opacity(0.45))
        }
    }
    
    /// every section's jelly's are put in here
    var listSectionView: some View {
        ForEach(beansViewModel.beans, id: \.self) { bean in
            NavigationLink {
                FlavourDetailView(beansViewModel: bean)
            } label: {
                VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            ZStack {
                                Group {
                                    Ellipse()
                                        .fill(Color(hex: "\(bean.backgroundColor)"))
                                        .frame(width: 32, height: 20)
                                    Ellipse()
                                        .fill(.white.opacity(0.7))
                                        .frame(width: 10, height: 5)
                                        .padding(.bottom, 10)
                                }
                                .rotationEffect(Angle(degrees: -35))
                            }
                            // the title and the subtitle
                            VStack(alignment: .leading) {
                                Text(bean.flavorName)
                                    .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
                            }
                            Spacer()
                            // the star
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                        }
                        .padding(.horizontal)
                }
                .padding(.vertical)
                .background {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(colorScheme == .dark ? Color.c_1E1B19 : Color.c_FFFFFF)
                }
            }
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
}

#Preview {
//    FlavoursView()
    CustomTabView()
        .environment(BeansViewModel())
}

