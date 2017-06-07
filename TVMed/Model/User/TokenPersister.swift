//
//  TokenPersister.swift
//  TVMed
//
//  Created by Vinicius Albino on 22/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import RealmSwift

class TokenPersister {
    
    private let realmPersister = RealmPersister()
    
    func saveToken(token: UserToken, callback: @escaping (_ success: Bool) -> Void) {
        realmPersister.saveUnique(object: token) { success in
            callback(success)
        }
    }
    
    func delete(callback: @escaping (_ success: Bool) -> Void) {
        realmPersister.deleteAllObjects(ofType: UserToken.self) { success in
            callback(success)
        }
    }
    
    func query(callback: @escaping (UserToken?) -> Void) {
        realmPersister.queryUnique(type:  UserToken.self) { success, object in
            if success, let token = object {
                callback(token)
            } else {
                callback(nil)
            }
        }
    }
}
