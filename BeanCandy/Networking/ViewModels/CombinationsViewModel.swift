//
//  CombinationsViewModel.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 26/08/26.
//

import Foundation

@Observable
class CombinationsViewModel {
    var combination: [CombinationModel.Combination] = []
    var isLoading : Bool = false
    var errorMessage : String?
    
    func loadCombinations() async {
        isLoading = true
        guard let url = API.finalUrl(for: .combinations) else {
            errorMessage = errorMessage ?? "Invalid URL"
            isLoading = false
            return
        }
        
        do {
            combination = try await fetchCombinations(url: url)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func fetchCombinations(url: URL) async throws -> [CombinationModel.Combination] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(CombinationModel.self, from: data)
        return response.items
    }
}
