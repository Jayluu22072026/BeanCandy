//
//  OnboardingView.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 22/08/26.
//

import SwiftUI

struct OnboardingView : View {
    @Environment(\.colorScheme) var colorScheme
    @State var selectedIndex: Int = 0
    @State var goToSigninView: Bool = false
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? Color.c_12100F : Color.c_F2EDE4).ignoresSafeArea()
            
            VStack{
                tabBarView
                
                nextGetStartedButton
                
                if selectedIndex == 2 {
                    skipButton.hidden()
                }else {
                    skipButton
                }
            }
            .padding(.horizontal, 30)
        }
        .navigationDestination(isPresented: $goToSigninView) {
            SigninView()
        }
    }
}

// MARK: Views
extension OnboardingView {
    var nextGetStartedButton: some View {
        Button{
          nextButtonLogic()
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .fill(colorScheme == .dark ? Color.c_FF6B6F : Color.c_E0343C)
                .frame(height: 50)
                .overlay {
                    Text(selectedIndex == 2 ? "Get Started" : "Next")
                        .foregroundStyle(.white)
                }
        }
    }
    
    var skipButton: some View {
        Button {
            skipButtonLogic()
        } label: {
            Text("Skip")
                .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.5) : Color.c_1C1418.opacity(0.45))
        }
    }
    
    var tabBarView: some View {
        TabView(selection: $selectedIndex){
            centerPill(
                color: OnboardingPage.CherryColor.PillColor,
                headLine: OnboardingPage.CherryColor.headline,
                subHead: OnboardingPage.CherryColor.subHeadline
            )
                .tag(0)
            centerPill(
                color: OnboardingPage.OrangeColor.PillColor,
                headLine: OnboardingPage.OrangeColor.headline,
                subHead: OnboardingPage.OrangeColor.subHeadline
            )
                .tag(1)
            centerPill(
                color: OnboardingPage.GreenColor.PillColor,
                headLine: OnboardingPage.GreenColor.headline,
                subHead: OnboardingPage.GreenColor.subHeadline
            )
                .tag(2)
        }
        .tabViewStyle(.page)
    }
    
    func centerPill(color: Color, headLine: String, subHead: String) -> some View {
        VStack{
            ZStack {
                Group {
                    Ellipse()
                        .fill(color)
                        .frame(width: 90, height: 60)
                    Ellipse()
                        .fill(.white.opacity(0.7))
                        .frame(width: 20, height: 10)
                        .padding(.bottom, 30)
                }
                .rotationEffect(Angle(degrees: -35))
                Circle()
                    .fill(color.opacity(0.4))
                    .frame(width: 200, height: 200)
            }
            Text(headLine)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8 : Color.c_1C1418)
            Text(subHead)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundStyle(colorScheme == .dark ? Color.c_F7F1E8.opacity(0.66) : Color.c_1C1418.opacity(0.6))
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: Logic extension
extension OnboardingView {
    func nextButtonLogic() {
        if selectedIndex < 2 {
            selectedIndex += 1
        }else {
            goToSigninView = true
        }
    }
    
    func skipButtonLogic() {
        goToSigninView = true
    }
}

// MARK: enums to make the view clean
enum OnboardingPage: Int, CaseIterable {
    case CherryColor, OrangeColor, GreenColor
    
    var id: Int { rawValue }
    
    var PillColor: Color {
        switch self {
        case .CherryColor : Color.veryCherryJelly
        case .OrangeColor: Color.tangerineJelly
        case .GreenColor : Color.greenAppleJelly
        }
    }
    
    var headline: String {
        switch self {
        case .CherryColor : "Every bean, catalogued"
        case .OrangeColor : "Mix your own"
        case .GreenColor : "Keep your notes"
        }
    }
    
    var subHeadline: String {
        switch self {
        case .CherryColor: "One hundred-plus official flavors with tasting notes, ingredients and the exact colour of each shell."
        case .OrangeColor: "Combine two beans and BeanBook tells you what the pair actually tastes like — and the ratio to chew."
        case .GreenColor: "Favourite the good ones, write down what you thought, and it stays on your phone."
        }
    }
    
}

#Preview {
    OnboardingView()
}
