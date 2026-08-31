//
//  FlavourDetailView.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 30/08/26.
//

import SwiftUI

struct FlavourDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    let beansViewModel : BeansModel.Beans
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? Color.c_12100F : Color.c_F2EDE4).ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    cherryNameTopDisplay
                    
                    descriptionView
                   
                    attributesView
                    
                    ingredientsView
                }
            }
            .scrollIndicators(.hidden)
            .padding()
        }
    }
}

// MARK: Logic
extension FlavourDetailView {
    // TODO: i have to still put in the favourtie button functionality
    /// in this we will put in the `@State` and `@Binding` to make it easy to use it in any other tabs also
}

// MARK: Views
extension FlavourDetailView {
    var cherryNameTopDisplay: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(hex: beansViewModel.backgroundColor).opacity(0.2))
                .frame(height: 150)
                .frame(maxWidth: .infinity)
            
            HStack {
                /// there will not be any image as there is some sort of issue in the image link, so it will always be the progress View
                /// so i have handled all the cases that can be done and in place of error i am putitng in a custom made shape for the cherry
                AsyncImage(url: URL(string: beansViewModel.imageUrl)) { phase in
                    switch phase {
                    case .empty :
                        ProgressView()
                    case .success(let image) :
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure :
                        ZStack {
                            Group {
                                Ellipse()
                                    .fill(Color(hex: "\(beansViewModel.backgroundColor)"))
                                    .frame(width: 92, height: 60)
                                Ellipse()
                                    .fill(.white.opacity(0.7))
                                    .frame(width: 20, height: 10)
                                    .padding(.bottom, 30)
                            }
                            .rotationEffect(Angle(degrees: -35))
                        }
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 100, height: 100)

                // Here we have the cherrry name and its color
                VStack(alignment: .leading) {
                    Text("Cherry Name")
                        .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
                        .font(.system(size: 26))
                        .fontWeight(.semibold)
                    Text(String(beansViewModel.backgroundColor))
                        .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.66) : Color.c_1C1418.opacity(0.6))
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
            }
        }
    }
    
    var descriptionView: some View {
        Text(beansViewModel.description)
            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.8) : Color.c_1C1418.opacity(0.78))
            .font(.system(size: 18))
    }
    
    var attributesView: some View {
        Group {
            /// we declared this inside the body as we needed to use `beansViewModel` which provided values for the attributes
            /// and declaring outside would not allow us to use the `beansViewModel`.
            let beanAttributes: [BeanAttributes] = [
                .init(attribute: "Gluten Free", attributesValue: beansViewModel.glutenFree),
                .init(attribute: "Kosher", attributesValue: beansViewModel.kosher),
                .init(attribute: "Sugar Free", attributesValue: beansViewModel.sugarFree)
            ]
            
            Text("Attributes")
                .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.5) : Color.c_1C1418.opacity(0.45))
                .fontWeight(.bold)
            
            VStack(alignment: .leading) {
                /// i have used `.enumerated()` to get the index and the value of the array and not used `.indices()`
                /// as it would make the code go long
                ForEach(Array(beanAttributes.enumerated()), id: \.element.id) { index, attribute in
                    HStack {
                        Text(attribute.attribute)
                        Spacer()
                        Text(String(attribute.attributesValue))
                            .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
                    }
                    .padding()
                    
                    /// here is the main reason we have used the `.enumerated()` so that i can get the index easily
                    if index < beanAttributes.count - 1 {
                        Divider()
                            .foregroundStyle(.gray)
                    }
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 22)
                    .fill(colorScheme == .dark ? Color.c_1E1B19 : Color.c_FFFFFF)
            }
        }
    }
    
    var ingredientsView: some View {
        Group {
            Text("Ingredients")
                .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.5) : Color.c_1C1418.opacity(0.45))
                .fontWeight(.bold)
            
            /// this is the basic array operation
            Text(String(beansViewModel.ingredients.joined(separator: ", ")))
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 22)
                        .fill(colorScheme == .dark ? Color.c_1E1B19 : Color.c_FFFFFF)
                }
        }
    }
}

#Preview {
    FlavourDetailView(
        beansViewModel: .init(
            beanId: 1,
            groupName: ["g1", "g2"],
            ingredients: ["I1", "I2", "I3"],
            flavorName: "Strawberrt",
            description: "New strawberry flavour",
            colorGroup: "Cherry",
            backgroundColor: "#3892D4",
            imageUrl: "https://cdn-tp1.mozu.com/9046-m1/cms/files/ab692677-5471-4863-91a8-659363ae4cc4",
            glutenFree: true,
            sugarFree: false,
            seasonal: false,
            kosher: true
        ))
}
