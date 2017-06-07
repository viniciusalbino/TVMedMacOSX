//
//  RealmEncrypted.swift
//  Shoestock
//
//  Created by Filipe Augusto de Souza Fragoso on 27/01/17.
//  Copyright © 2017 Netshoes. All rights reserved.
//

import Foundation
import RealmSwift

class RealmEncrypted {
    
    private static let realmKey = "br.com.TvMed.realm.io"
    
    /// Sets the default realm to use encryption rather than returning
    /// an instance of Realm as suggested in the documentation. This
    /// is intentional because when querying, a realm is not specified.
    /// This leads to Realm throwing the exception:
    ///
    /// "default.realm" already opened with different encryption key.
    ///
    /// This method also must be the first access to Realm in the
    /// application. Otherwise there is a risk that there will be
    /// two Realm instances open and the above exception will be
    /// thrown.
    
    class func realm() throws -> Realm {
        guard Realm.Configuration.defaultConfiguration.encryptionKey == nil else {
            let realm = try Realm()
            realm.refresh()
            return realm
        }
        
        var config = Realm.Configuration.defaultConfiguration
        config.schemaVersion = 4
        config.migrationBlock = { migration, oldSchemaVersion in
        }
        Realm.Configuration.defaultConfiguration = config
        
        Realm.Configuration.defaultConfiguration.encryptionKey = getKey()
        let realm = try Realm()
        print(realm)
        realm.refresh()
        return realm
    }
    
    class func getKey() -> Data? {
        if let encryptedKey = KeychainAccess.load(key: realmKey) {
            return encryptedKey
        }
        if createKey() {
            return getKey()
        }
        return nil
    }

    private class func createKey() -> Bool {
        let length = 64
        guard let buffer = NSMutableData(length: Int(length)) else {
            return false
        }
        var bytes = [UInt8](repeating:0, count:length)
        buffer.getBytes(&bytes, length: length * MemoryLayout<UInt8>.size)
        _ = SecRandomCopyBytes(kSecRandomDefault, length, UnsafeMutablePointer<UInt8>(mutating: bytes))
        let data = NSData(bytes: bytes, length: length)
        return KeychainAccess.save(key: realmKey, data: data)
    }
}
