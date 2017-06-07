//
//  RealmToGroupsMigrator.swift
//  Shoestock
//
//  Created by Filipe Augusto de Souza Fragoso on 30/01/17.
//  Copyright © 2017 Netshoes. All rights reserved.
//

import Foundation
import RealmSwift

class RealmToGroupsMigrator {
    static var realmSchemeVersion: UInt64 {
        return 4
    }
    
    class func migrateRealm() {
        var config = Realm.Configuration.defaultConfiguration
        config.schemaVersion = realmSchemeVersion
        config.migrationBlock = { migration, oldSchemaVersion in
        }
        Realm.Configuration.defaultConfiguration = config
        //Cache original realm path (documents directory)
        
        do {
            guard let originalDefaultRealmPath = try RealmEncrypted.realm().configuration.fileURL?.absoluteString else {
                return
            }

            //Generate new realm path based on app group
            let appGroupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.tvmed.TVMedOSX")!
            let realmPath = appGroupURL.appendingPathComponent("default.realm").path 
            //Moves the realm to the new location if it hasn't been done previously
            
            if FileManager.default.fileExists(atPath: originalDefaultRealmPath) && !FileManager.default.fileExists(atPath: realmPath) {
                do {
                    try FileManager.default.moveItem(atPath: originalDefaultRealmPath, toPath: realmPath)
                    //Set the realm path to the new directory
                    config.fileURL = URL(string: realmPath)
                    Realm.Configuration.defaultConfiguration = config
                    
                    do {
                        try FileManager.default.removeItem(at: URL(string: originalDefaultRealmPath)!)
                    } catch let error as NSError {
                        print("Ooops! Something went wrong deleting : \(error)")
                    }
                } catch let error as NSError {
                    print("Ooops! Something went wrong: \(error)")
                }
            } else {
                config.fileURL = URL(string: realmPath)
                Realm.Configuration.defaultConfiguration = config
            }
        } catch {
            #if DEBUG
                assertionFailure(error.localizedDescription)
            #endif
        }
    }
}
