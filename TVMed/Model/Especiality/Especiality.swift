//
//  Especiality.swift
//  TVMed
//
//  Created by Vinicius Albino on 06/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import ObjectMapper

struct Especiality: Mappable {
    var codigo = 0
    var especialidade = ""
    var descricao = ""
    var prefixo = ""
    var sufixo = ""
    var image = ""
    var congressImage = ""
    var congressoNome = ""
    var data_evento = Date()
    var tipoMidia = 0
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    init() {
        
    }
    
    // Mappable
    mutating func mapping(map: Map) {
        codigo        <- map["codigo"]
        especialidade  <- map["especialidade"]
        prefixo  <- map["prefixo"]
        sufixo    <- map["sufixo"]
        congressImage <- map["congressImage"]
        image        <- map["bannerImage"]
        descricao          <- map["descricao"]
        congressoNome  <- map["congressoNome"]
        data_evento    <- map["data_evento"]
        tipoMidia <- map["tipoMidia"]
    }
}
