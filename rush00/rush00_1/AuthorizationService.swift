//
//  AuthorizationService.swift
//  rush00_1
//
//  Created by Oleksandr MALTSEV on 6/30/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import Foundation

class AuthorizationService {

    static func setToken(token: String) {
        UserDefaults.standard.set(token, forKey: "accessToken")
    }
    
    static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
}
