//
//  RemoteCreditCard.swift
//  TVMed
//
//  Created by Vinicius de Moura Albino on 14/04/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import ObjectMapper

struct RemoteCreditCard: Mappable {
    var identifier = ""
    var bandeira = 0
    var numero = ""
    var principal = false
    var vencido = false
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    init() {
        
    }
    
    // Mappable
    mutating func mapping(map: Map) {
        identifier <- map["id"]
        bandeira  <- map["bandeira"]
        numero  <- map["numero"]
        principal  <- map["principal"]
        vencido  <- map["vencido"]
    }
    
    func parameters() -> JSONDictionary {
        return ["cartaoBandeira" : bandeira,
                "usarUltimoCartaoValido" : true]
    }
}
