//
//  FlavourSection.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 30/08/26.
//

import Foundation
import SwiftUI

struct FlavourSection: Identifiable {
    var id = UUID()
    let category: String
    let flavours : [String : Color]
}
