//
//  FactsViewModel.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 26/08/26.
//

import Foundation
import SwiftUI

@Observable
class FactsViewModel {
    var facts: [FactsModel.Fact] = []
    var isLoading: Bool = false
    var errorMessage : String?
    
    func loadFacts() async {
        isLoading = true
        guard let url = API.finalUrl(for: .facts) else {
            errorMessage = errorMessage ?? "Invalid URL"
            isLoading = false
            return
        }
        do {
            facts = try await fetchFacts(url: url)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func fetchFacts(url: URL) async throws -> [FactsModel.Fact] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(FactsModel.self, from: data)
        return response.items
    }
    
}
