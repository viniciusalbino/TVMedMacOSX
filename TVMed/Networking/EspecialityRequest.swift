//
//  EspecialityRequest.swift
//  TVMed
//
//  Created by Vinicius Albino on 06/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
class EspecialityRequest  {
    
    func request(callback: @escaping ([Especiality]?, ErrorTypeApp?) -> ()) {
        HeaderBuilder().GET(url: "/congresso/especialidade/todas/pt-br", params: [:]) { result, error, response in
            
            guard error == nil else {
                callback(nil, error)
                return
            }
            let result = result as? [JSONDictionary] <*> (Especiality.self, error)
            callback(result.object, result.error)
        }
    }
    
    func filterEspeciality(especialidade: String, callback: @escaping ([Especiality]?, ErrorTypeApp?) -> ()) {
        let url = "/congresso/especialidade/\(especialidade)/pt-br"
        HeaderBuilder().GET(url: url, params: [:]) { result, error, response in
            guard error == nil else {
                callback(nil, error)
                return
            }
            let result = result as? [JSONDictionary] <*> (Especiality.self, error)
            callback(result.object, result.error)
        }
    }
    
    func getMidiaCongress(congressID: String, callback: @escaping ([MidiaPromotion]?, ErrorTypeApp?) ->()) {
        let url = "/congresso/midiascongresso/\(congressID)/"
        HeaderBuilder().GET(url: url, params: [:]) { result, error, response in
            guard error == nil else {
                callback(nil, error)
                return
            }
            let result = result as? [JSONDictionary] <*> (MidiaPromotion.self, error)
            callback(result.object, result.error)
        }
    }
}
