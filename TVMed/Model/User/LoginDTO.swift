//
//  LoginDTO.swift
//  TVMed
//
//  Created by Vinicius Albino on 22/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation

struct LoginDTO { 
    var email = ""
    var password = ""
    var rememberMe = true
    var qualtab = 0
    
    func parameters() -> JSONDictionary {
        return ["email": email,
                "password": password,
                "rememberMe": rememberMe,
                "qualtab": qualtab]
    }
}
