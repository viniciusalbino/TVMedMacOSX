//
//  UserRequests.swift
//  TVMed
//
//  Created by Vinicius Albino on 31/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation

class UserRequests  {
    func requestUserData(callback: @escaping (User?, ErrorTypeApp?) -> ()) {
        HeaderBuilder().GET(url: "medico/meusdados", params: [:]) { result, error, response in
            guard error == nil else {
                callback(nil, error)
                return
            }
            
            let result = result <*> (User.self, error)
            callback(result.object, result.error)
        }
    }
    
    func getCreditCards(callback: @escaping ([RemoteCreditCard]?, ErrorTypeApp?) -> ()) {
        HeaderBuilder().buildHeader { defaultHeaders in
            BaseRequest().GET(url: "medico/cartoes", params: [:], headers: defaultHeaders, callback: { result, error, response in
                guard error == nil else {
                    callback(nil, error)
                    return
                }
                let result = result as? [JSONDictionary] <*> (RemoteCreditCard.self, error)
                callback(result.object, result.error)
            })
        }
    }
    
    func changeCreditCard(cardId: RemoteCreditCard, callback: @escaping ([RemoteCreditCard]?, ErrorTypeApp?) -> ()) {
        let url = "medico/cartoes/\(cardId.identifier)/principal"
        HeaderBuilder().buildHeader { defaultHeaders in
            BaseRequest().PUT(url: url, params: [:], headers: defaultHeaders, callback: { result, error, response in
                guard error == nil else {
                    callback(nil, error)
                    return
                }
                
                let result = result as? [JSONDictionary] <*> (RemoteCreditCard.self, error)
                callback(result.object, result.error)
            })
        }
    }
}
