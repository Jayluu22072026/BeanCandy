//
//  UserModel.swift
//  BeanCandy
//
//  Created by Jayluu's Mac on 14/09/26.
//

import Foundation
import FirebaseAuth

struct UserAuth {
    let uid : String
    let email : String?
    let displayName : String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.displayName = user.displayName
    }
    
}
