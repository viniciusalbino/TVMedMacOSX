//
//  CategoriesRequest.swift
//  TVMed
//
//  Created by Vinicius Albino on 23/02/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import Cocoa

class CategoriesRequest  {
    func request(callback: @escaping ([Categorie]?, ErrorTypeApp?) -> ()) {
        HeaderBuilder().GET(url: "tabelas/especialidades", params: [:]) { result, error, response in
            
            guard error == nil else {
                callback(nil, error)
                return
            }
            let result = result as? [JSONDictionary] <*> (Categorie.self, error)
            callback(result.object, result.error)
        }
    }
}
