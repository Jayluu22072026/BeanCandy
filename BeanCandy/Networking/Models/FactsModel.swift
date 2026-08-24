//
//  FactsModel.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 23/08/26.
//

import Foundation

struct FactsModel: Codable , Identifiable {
    var id = UUID()
    let totalCount: Int
    let pageSize: Int
    let currentPage: Int
    let totalPages: Int
    let items : [Fact]
    
    struct Fact: Codable {
        let factId : Int
        let title: String
        let description: String
    }
}
