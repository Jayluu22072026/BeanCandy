//
//  CombinationModel.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 23/08/26.
//

import Foundation

struct CombinationModel: Codable , Identifiable {
    var id = UUID()
    let totalCount: Int
    let pageSize: Int
    let currentPage: Int
    let totalPage: Int
    let items: [Combination]
    
    struct Combination: Codable {
        let combinationId: Int
        let name: String
        let tag : [String]
    }
}
