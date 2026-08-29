//
//  ColorFile.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 22/08/26.
//

import Foundation
import SwiftUI

extension Color {
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let red = Double((int >> 16) & 0xFF) / 255.0
        let green = Double((int >> 8) & 0xFF) / 255.0
        let blue = Double(int & 0xFF) / 255.0
        
        self.init(
            red: red,
            green: green,
            blue: blue
        )
    }
    // background
    static let c_F2EDE4 = Color(hex: "#F2EDE4") // light mode
    static let c_12100F = Color(hex: "#12100F") // dark mode
    
    static let c_000000 = Color(hex: "#000000") // black color
    static let c_FFFFFF = Color(hex: "#FFFFFF") // white color
    static let c_1E1B19 = Color(hex: "#1E1B19") // dark mode
    static let c_FDF6EC = Color(hex: "#FDF6EC") 
    // font colors
    static let c_1C1418 = Color(hex: "#1C1418") // light mode
    static let c_F7F1E8 = Color(hex: "#F7F1E8") // dark mode
    
    static let c_E0343C = Color(hex: "#E0343C") // light mode
    static let c_FF6B6F = Color(hex: "FF6B6F") // dark mode
        
    
    // jellys and their colored names
    /// Fruit
    static let veryCherryJelly          = Color(hex: "#E0343C")
    static let juicyPearJelly           = Color(hex: "#C8D94B")
    static let blueberryJelly           = Color(hex: "#4A63B5")
    static let greenAppleJelly          = Color(hex: "#63B33B")
    static let watermelonJelly          = Color(hex: "#F0576F")
    static let berryBlueJelly           = Color(hex: "#2E6FD9")
    static let topBananaJelly           = Color(hex: "#F2D14A")
    
    /// Citrus
    static let tangerineJelly           = Color(hex: "#F5872E")
    static let lemonDropJelly           = Color(hex: "#F2E24A")
    
    /// Sweet
    static let butteredPopcornJelly     = Color(hex: "#F5D23B")
    static let toastedMarshmellowJelly  = Color(hex: "#EBD6BC")
    static let coconutJelly             = Color(hex: "#FAF3EA")
    static let cottonCandyJelly         = Color(hex: "#F09BD1")
    
    /// Spice
    static let sizzlingCinnamonJelly    = Color(hex: "#C62828")
    static let licoriceJelly            = Color(hex: "#2A2226")
    
    /// Soda
    static let rootBeerJelly            = Color(hex: "#7B4A2A")
}
