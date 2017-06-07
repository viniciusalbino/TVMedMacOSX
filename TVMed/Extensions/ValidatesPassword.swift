//
//  ValidatesPassword.swift
//  TVMed
//
//  Created by Vinicius Albino on 25/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation

protocol ValidatesPassword {
    func isPasswordValid(password: String) -> Bool
}

extension ValidatesPassword {
    func isPasswordValid(password: String) -> Bool {
        
        guard !password.isEmpty else {
            return false
        }
        
        if password.length() <= 3 {
            return false
        } else {
            return true
        }
    }
}
