//
//  NewReleasesRequest.swift
//  TVMed
//
//  Created by Vinicius Albino on 21/02/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation

class NewReleasesRequest  {
    func request(callback: @escaping ([Release]?, ErrorTypeApp?) -> ()) {
        HeaderBuilder().GET(url: "congresso/lancamentos/pt-BR", params: [:]) { result, error, response in
            guard error == nil else {
                callback(nil, error)
                return
            }
            let result = result as? [JSONDictionary] <*> (Release.self, error)
            callback(result.object, result.error)
        }
    }
    
    func getMidiaPromotion(congressoId: String, callback: @escaping ([MidiaPromotion]?, ErrorTypeApp?) -> ()) {
        let url = "/congresso/midiaspromocao/\(congressoId)/pt-br"
        HeaderBuilder().GET(url: url, params: [:]) { result, error, response in
            guard error == nil else {
                callback(nil, error)
                return
            }
            let result = result as? [JSONDictionary] <*> (MidiaPromotion.self, error)
            callback(result.object, result.error)
        }
    }
    
    func getTopic(midia: MidiaPromotion, callback: @escaping (MidiaDetail?, ErrorTypeApp?) -> ()) {
        let url = "/congresso/\(midia.congresso)/midia/\(midia.midia)/topicos"
        HeaderBuilder().buildHeader { defaultHeaders in
            BaseRequest().GET(url: url, params: [:], headers: defaultHeaders, callback: { result, error, response in
                guard error == nil else {
                    callback(nil, error)
                    return
                }
                
                let result = result <*> (MidiaDetail.self, error)
                callback(result.object, result.error)
            })
        }
    }
}
