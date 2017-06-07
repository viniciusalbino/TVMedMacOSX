//
//  MidiaSubTopic.swift
//  TVMed
//
//  Created by Vinicius de Moura Albino on 15/04/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import ObjectMapper

struct MidiaSubTopic: Mappable {
    
    var ordem = 0
    var titulo = ""
    var subtopicoId = ""
    var videoFileId = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    init() {
        
    }
    
    mutating func mapping(map: Map) {
        ordem <- map["ordem"]
        titulo <- map["titulo"]
        subtopicoId <- map["subtopicoId"]
        videoFileId <- map["videoFileId"]
    }
}
