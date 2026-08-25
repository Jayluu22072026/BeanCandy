//
//  TestEnumFile.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 25/08/26.
//

import Foundation
import SwiftUI

enum API {
    static let baseURL = "https://jellybellywikiapi.onrender.com/api"
    
    enum EndPoint {
        case beans, facts, combinations, recipes
        var path: String {
            switch self {
            case .beans : return "/beans"
            case.facts : return "/facts"
            case .combinations : return "/combinations"
            case .recipes : return "/recipes"
            }
        }
    }
    
    static func finalUrl(for endPoint: EndPoint) -> URL? {
        return URL(string: API.baseURL + endPoint.path)
    }
}

