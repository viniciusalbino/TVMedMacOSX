//
//  MidiaDetail.swift
//  TVMed
//
//  Created by Vinicius de Moura Albino on 15/04/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import ObjectMapper

struct MidiaDetail: Mappable {
    
    var congressoNumero = 0
    var congressoTitulo = ""
    var midia = 0
    var sinopse = ""
    var congressoCNA = false
    var topicos = [MidiaTopic]()
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    init() {
        
    }
    
    mutating func mapping(map: Map) {
        congressoNumero <- map["congressoNumero"]
        congressoTitulo <- map["congressoTitulo"]
        midia <- map["midia"]
        sinopse <- map["sinopse"]
        congressoCNA <- map["congressoCNA"]
        topicos <- map["topicos"]
    }
}
