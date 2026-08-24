//
//  BeansModel.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 23/08/26.
//

import Foundation

struct BeansModel: Codable, Identifiable {
    var id = UUID()
    let totalCount: Int
    let pageSize: Int
    let currentPage: Int
    let totalPages: Int
    let items: [Beans]
    
    struct Beans: Codable {
        let beanId: Int
        let groupName: [String]
        let ingredients: [String]
        let flavorName: String
        let description: String
        let colorGroup: String
        let backgroundColor: String
        let imageUrl: String
        let glutenFree: Bool
        let sugarFree: Bool
        let seasonal: Bool
        let kosher: Bool
    }
}
