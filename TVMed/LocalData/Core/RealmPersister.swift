//
//  RealmPersister.swift
//  Shoestock
//
//  Created by Filipe Augusto de Souza Fragoso on 24/01/17.
//  Copyright © 2017 Netshoes. All rights reserved.
//

import Foundation
import RealmSwift

protocol ParentObject {
    func getObjectProperties() -> [Object]?
}

class RealmPersister: Object {
    
    private static let realmQueue = DispatchQueue(label: BundleHelper.bundleIdentifier())
    
    //mark: Saving Methods
    func saveUnique<T: Object>(object: T, completion: @escaping (_ success: Bool) -> Void) {
        deleteAllObjects(ofType: T.self) { deleteSuccess in
            if deleteSuccess {
                self.saveObjects(objects: [object]) { saveSucess in
                    saveSucess ? completion(true) : completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    
    func saveObjects<T: Object>(objects: [T]?, completion: @escaping (_ success: Bool) -> Void) {
        RealmPersister.realmQueue.async {
            if T.primaryKey() == nil {
                self.saveNonUniqueObjects(objects: objects) { success in
                    completion(success)
                }
            } else {
                self.saveUniqueObjects(objects: objects) { success in
                    completion(success)
                }
            }
        }
    }
    
    private func saveNonUniqueObjects(objects: [Object]?, completion: @escaping (_ success: Bool) -> Void) {
        guard let objects = objects, !objects.isEmpty else {
            completion(false)
            return
        }
        do {
            let realm = try RealmEncrypted.realm()
            try realm.write {
                realm.add(objects)
                completion(true)
            }
        } catch {
            completion(false)
            print("Realm did not write objects! \(objects)")
        }
    }
    
    private func saveUniqueObjects(objects: [Object]?, completion: @escaping (_ success: Bool) -> Void) {
        guard let objects = objects, !objects.isEmpty else {
            completion(false)
            return
        }
        do {
            let realm = try RealmEncrypted.realm()
            try realm.write {
                realm.add(objects, update: true)
                completion(true)
            }
        } catch {
            completion(false)
            print("Realm did not write objects! \(objects)")
        }
    }
    
    //mark: Deleting Methods
    func deleteObjects(objects: [Object]?, completion: @escaping (_ success: Bool) -> Void) {
        RealmPersister.realmQueue.async {
            self.delete(objects: objects) { sucess in
                completion(sucess)
            }
        }
    }
    
    func deleteAllObjects<T: Object>(ofType type: T.Type, completion: @escaping (_ success: Bool) -> Void) {
        RealmPersister.realmQueue.async {
            do {
                let realm = try RealmEncrypted.realm()
                self.delete(objects: Array(realm.objects(T.self))) { success in
                    completion(success)
                }
            } catch {
                print("Realm did not delete objects of type \(T())!")
                completion(false)
            }
         }
    }
    
    private func delete(objects: [Object]?, completion: @escaping (_ success: Bool) -> Void) {
        guard let objects = objects, !objects.isEmpty else {
            completion(true)
            return
        }
        do {
            let realm = try RealmEncrypted.realm()
            try realm.write {
                deleteChildren(ofObjects: objects)
                realm.delete(objects)
                completion(true)
            }
        } catch {
            print("Realm did not delete objects! \(objects)")
            completion(false)
        }
    }
    
    private func deleteChildren(ofObjects objects: [Object]?) {
        do {
            let realm = try RealmEncrypted.realm()
            guard let objects  = objects else {
                return
            }
            for object in objects {
                if let parentObject = object as? ParentObject, let childrenObjects = parentObject.getObjectProperties() {
                    deleteChildren(ofObjects: childrenObjects)
                    realm.delete(childrenObjects)
                }
            }
        } catch {
            print("Error to delete children objects")
        }
    }
    
    //mark: Querying Methods
    func query<T: Object>(type: T.Type, completion: @escaping (_ success: Bool, _ objects: [T]?) -> Void) {
        RealmPersister.realmQueue.async {
            do {
                let realm = try RealmEncrypted.realm()
                let objects = Array(realm.objects(T.self))
                objects.isEmpty ? completion(false, nil) : completion(true, objects)
            } catch {
                completion(false, nil)
                print("Realm did not query objects!")
            }
        }
    }
    
    func queryUnique<T: Object>(type: T.Type, completion: @escaping (_ success: Bool, _ object: T?) -> Void) {
        RealmPersister.realmQueue.async {
            do {
                let realm = try RealmEncrypted.realm()
                let object = realm.objects(T.self).first
                completion(object != nil, object)
            } catch {
                print("Realm did not query objects!")
                completion(false, nil)
            }
        }

    }
    
    func wipeAllPerstience(completion: @escaping (_ success: Bool) -> Void) {
        RealmPersister.realmQueue.async {
            do {
                let realm = try RealmEncrypted.realm()
                try realm.write {
                    realm.deleteAll()
                    completion(true)
                }
            } catch {
                print("Realm did not wipe persitence!")
                completion(false)
            }
        }
    }
    
    func querySync<T: Object>(type: T.Type) -> [T]? {
        do {
            let realm = try RealmEncrypted.realm()
            let objects = Array(realm.objects(T.self))
            return objects
        } catch {
            return nil
        }
    }
}
