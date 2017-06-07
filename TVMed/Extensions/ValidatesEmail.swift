//
//  ValidatesEmail.swift
//  TVMed
//
//  Created by Vinicius Albino on 25/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation

protocol ValidatesEmail {
    func isEmailValid(email: String) -> Bool
}

extension ValidatesEmail {
    func isEmailValid(email: String) -> Bool {
        
        guard !email.isEmpty else {
            return false
        }
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let isEmailValid = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return isEmailValid.evaluate(with: email)
    }
}
