//
//  Releases.swift
//  TVMed
//
//  Created by Vinicius Albino on 21/02/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import ObjectMapper

struct Release: Mappable {
    var uniqueID = ""
    var site = ""
    var lingua = ""
    var numero = ""
    var titulo = ""
    var image = ""
    var descricao = ""
    var congresso = 0
    var fitas = ""
    var ativado = false
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    init() {
        
    }
    
    // Mappable
    mutating func mapping(map: Map) {
        uniqueID        <- map["r_uniqueid"]
        site          <- map["pR_SITE"]
        lingua  <- map["pR_LINGUA"]
        numero    <- map["pR_NUMERO"]
        titulo <- map["pR_TITULO"]
        image        <- map["pR_GIF_JPG"]
        descricao          <- map["pR_DESCR"]
        congresso  <- map["pR_CONGR"]
        fitas    <- map["pR_FITAS"]
        ativado <- map["pR_ATIVADO"]
    }
}

