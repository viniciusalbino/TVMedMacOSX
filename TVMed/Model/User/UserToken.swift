//
//  UserToken.swift
//  TVMed
//
//  Created by Vinicius Albino on 22/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class UserToken: Object, Mappable {
    
    dynamic var email = ""
    dynamic var expiresUTC = Date()
    dynamic var token = ""
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        email <- map["email"]
        expiresUTC <- map["expiresUtc"]
        token <- map["token"]
    }
    
    func tokenApiFormat() -> String {
        return "Bearer \(token)"
    }
}
