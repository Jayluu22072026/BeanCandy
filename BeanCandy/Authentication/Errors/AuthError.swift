//
//  AuthError.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 17/09/26.
//

import Foundation

enum AuthError: Error {
    case failLogin
    case networkError
    case firebase(String) // this wraps a raw firebase error
    
    var message: String {
        switch self {
        case .failLogin : return "Failed to login"
        case .networkError : return "Network error occurred"
        case .firebase(let message): return message
        }
    }
}
