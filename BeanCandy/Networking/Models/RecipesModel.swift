//
//  RecipesModel.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 23/08/26.
//

import Foundation

struct RecipesModel: Codable , Identifiable {
    var id = UUID()
    let totalCount: Int
    let pageSize: Int
    let currentPage: Int
    let totalPages: Int
    let items: [Recipe]
    
    struct Recipe : Codable {
        let recipeId: Int
        let name: String
        let description: String
        let prepTime: String
        let cookTime: String
        let totalTime: String
        let makingAmount: String
        let imageUrl: String
        let ingredients: [String]
        let additions1: [String]
        let additions2: [String]
        let additions3: [String]
        let directions: [String]
        let tips: [String]
    }
}
