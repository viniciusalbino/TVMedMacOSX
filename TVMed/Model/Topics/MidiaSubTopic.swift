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
    
    var urlInDocumentsDirectory: URL? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if paths.count > 0 {
            let path = paths[0]
            if let directory = URL(string: path) {
                let fileURL = directory.appendingPathComponent(subtopicoId)
                return fileURL
            }
        }
        return nil
    }
    
    mutating func mapping(map: Map) {
        ordem <- map["ordem"]
        titulo <- map["titulo"]
        subtopicoId <- map["subtopicoId"]
        videoFileId <- map["videoFileId"]
    }
}
