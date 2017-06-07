//
//  VideoToken.swift
//  TVMed
//
//  Created by Vinicius de Moura Albino on 15/04/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import ObjectMapper

struct VideoToken: Mappable {
    var token = ""
    var server = ""
    var videoUri = ""
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    init() {
        
    }
    
    mutating func mapping(map: Map) {
        server <- map["server"]
        token <- map["token"]
        videoUri <- map["videoUri"]
    }
}
