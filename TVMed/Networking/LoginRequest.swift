//
//  LoginRequest.swift
//  TVMed
//
//  Created by Vinicius Albino on 22/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import Alamofire

class LoginRequest {
    
    private let persister = TokenPersister()
    
    func request(loginDTO: LoginDTO, callback: @escaping (UserToken?, ErrorTypeApp?) -> ()) {
        BaseRequest().POST(url: "login", params: loginDTO.parameters(), headers: TVMedBaseRequestHeaders().headers()) { result, error, response in
            print(result)
            guard error == nil else {
                callback(nil, error)
                return
            }
            let result = result <*> (UserToken.self, error)
            if let token = result.object {
                self.persister.saveToken(token: token, callback: { success in
                    guard success else  {
                        callback(nil, ErrorTypeApp.forced)
                        return
                    }
                    callback(token, nil)
                })
            } else  {
                callback(nil, result.error)
            }
        }
    }
    
    func validateToken(callback: @escaping (Bool) -> ()) {
        let finalURL = "\(domain)login/validation"        
        HeaderBuilder().buildHeader { defaultHeaders in
            Alamofire.request(finalURL, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: defaultHeaders).responseJSON { response in
                if let response = response.response {
                    if response.statusCode == 200 {
                        callback(true)
                    } else {
                        callback(false)
                    }
                } else {
                    callback(false)
                }
            }
        }
    }
}
