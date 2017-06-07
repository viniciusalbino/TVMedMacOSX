//
//  Categorie.swift
//  TVMed
//
//  Created by Vinicius Albino on 23/02/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import ObjectMapper

struct Categorie: Mappable{
    
    var codigo = ""
    var descricao = ""
    var descricao_en = ""
    var descricao_es = ""
    var nrseq = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    init() {
        
    }
    
    // Mappable
    mutating func mapping(map: Map) {
        codigo        <- map["codigo"]
        descricao        <- map["descricao"]
        descricao_en        <- map["descricao_en"]
        descricao_es        <- map["descricao_es"]
        nrseq        <- map["nrseq"]
    }
}
