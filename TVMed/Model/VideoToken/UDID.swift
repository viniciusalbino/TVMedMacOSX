//
//  UDID.swift
//  TVMed
//
//  Created by Vinicius de Moura Albino on 15/04/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

struct VideoTokenDTO {
    var subTopicoId = ""
    var uid = ""
    
    func parameters() -> JSONDictionary {
        return ["uid": uid,
                "subTopicoId" : subTopicoId]
    }
}

struct UIDDTO {
    var uid = ""
    var nome = ""
    var tipoDispositivo = 0
    
    func parameters() -> JSONDictionary {
        return ["uid" : uid,
                "nome" : nome,
                "tipoDispositivo" : tipoDispositivo]
    }
}

class UDID: Object, Mappable {
    
    dynamic var uid = ""
    dynamic var deviceName = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        uid <- map["uid"]
        deviceName <- map["deviceName"]
    }
}
