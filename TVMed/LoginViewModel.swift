//
//  LoginViewModel.swift
//  TVMed
//
//  Created by Vinicius Albino on 25/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation

protocol LoginDelegate: class {
    func contentDidFinishedLoading(success: Bool)
}

class LoginViewModel: ValidatesPassword, ValidatesEmail {
    
    weak var delegate: LoginDelegate?
    private let persister = TokenPersister()
    
    init(delegate: LoginDelegate) {
        self.delegate = delegate
    }
    
    func validatesLogin(password: String, email: String) -> Bool {
        guard isPasswordValid(password: password), isEmailValid(email: email) else {
            return false
        }
        return true
    }
    
    func loginRequest(email: String, password: String) {
        let loginDTO = LoginDTO(email: email, password: password, rememberMe: true, qualtab: 0)
        let request = LoginRequest()
        request.request(loginDTO: loginDTO) { token, error in
            guard error == nil, let userToken = token else {
                DispatchQueue.main.async {
                    self.delegate?.contentDidFinishedLoading(success: false)
                }
                return
            }
            DispatchQueue.main.async {
                self.delegate?.contentDidFinishedLoading(success: true)
            }
        }
    }
}
