//
//  OrdersRequest.swift
//  TVMed
//
//  Created by Vinicius Albino on 28/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation

class OrdersRequest {
    func request(callback: @escaping ([MidiaPromotion]?, ErrorTypeApp?) -> ()) {
        HeaderBuilder().GET(url: "/pedido/meusprodutos", params: [:]) { result, error, response in
            
            guard error == nil else {
                callback(nil, error)
                return
            }
            let result = result as? [JSONDictionary] <*> (MidiaPromotion.self, error)
            callback(result.object, result.error)
        }
    }
}
