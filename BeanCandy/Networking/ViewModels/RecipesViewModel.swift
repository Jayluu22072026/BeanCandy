//
//  RecipesViewModel.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 26/08/26.
//

import Foundation

@Observable
class RecipesViewModel {
    var recipes: [RecipesModel.Recipe] = []
    var isLoading : Bool = false
    var errorMessage : String?
    
    func loadRecipes() async {
        isLoading = true
        guard let url = API.finalUrl(for: .recipes) else {
            errorMessage = errorMessage ?? "Invalid URL"
            isLoading = false
            return
        }
        
        do {
            recipes = try await fetchRecipes(url: url)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func fetchRecipes(url: URL) async throws -> [RecipesModel.Recipe] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(RecipesModel.self, from: data)
        return response.items
    }
    
}
