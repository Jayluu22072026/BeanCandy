//
//  BeansViewModel.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 23/08/26.
//

import SwiftUI
import Foundation

@Observable
class BeansViewModel {
    var beans: [BeansModel.Beans] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    func loadBeans() async {
        isLoading = true
        guard let url = URL(string: "https://jellybellywikiapi.onrender.com/api/beans") else {
            errorMessage = "Invalid url"
            isLoading = false
            return
        }
        do {
            beans = try await fetchBeans(url : url)
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    func fetchBeans(url: URL) async throws -> [BeansModel.Beans] {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode([BeansModel.Beans].self, from: data)
    }
    
}
