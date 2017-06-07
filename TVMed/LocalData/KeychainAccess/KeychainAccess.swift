//
//  KeychainAccess.swift
//  Shoestock
//
//  Created by Filipe Augusto de Souza Fragoso on 27/01/17.
//  Copyright © 2017 Netshoes. All rights reserved.
//

import Foundation

class KeychainAccess: NSObject {
    
    static let keychainIdentifier = "br.com.TvMed.keychain"
    
    class func load(key: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: keychainIdentifier as AnyObject,
            kSecAttrAccount: key as AnyObject,
            kSecReturnAttributes: true as AnyObject,
            kSecReturnData: true as AnyObject
            ] as [NSString: AnyObject]
        
        var result: AnyObject?
        let err = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard let dictionary = result as? [NSString : AnyObject],
            let data = dictionary[kSecValueData] as? Data, err == errSecSuccess || err == errSecItemNotFound else {
                return nil
        }
        
        return data
    }
    
    class func save(key: String, data: NSData?) -> Bool {
        guard let safeData = data else {
            return false
        }
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: keychainIdentifier as AnyObject,
            kSecAttrAccount: key as AnyObject,
            kSecValueData: safeData
            ] as [NSString: AnyObject]
        
        let result = SecItemAdd(query as CFDictionary, nil)
        
        return result == errSecSuccess
    }
    
    class func delete(key: String) -> Bool {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: keychainIdentifier as AnyObject,
            kSecAttrAccount: key as AnyObject
            ] as [NSString: AnyObject]
        
        let result = SecItemDelete(query as CFDictionary)
        
        return result == errSecSuccess
    }
    
    // MARK: - Convenience methods
    
    class func save(key: String, string: String?) -> Bool {
        return save(key: key, data: string?.data(using: String.Encoding.utf8) as NSData?)
    }
    
    class func loadString(key: String) -> String? {
        guard let data = load(key: key) else {
            return nil
        }
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
}

class KeychainAccessOld: NSObject {
    static let oldKeychainIndetifier =  "TVMed"
    
    class func loadOldKeychain(key: String) -> AnyObject? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: oldKeychainIndetifier as AnyObject,
            kSecAttrAccount: key as AnyObject,
            kSecReturnAttributes: true as AnyObject,
            kSecReturnData: true as AnyObject
            ] as [NSString: AnyObject]
        
        var result: AnyObject?
        let err = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard let dictionary = result as? [NSString : AnyObject],
            let data = dictionary[kSecValueData] as? Data, err == errSecSuccess || err == errSecItemNotFound else {
                return nil
        }
        
        return NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject?
    }
    
    class func save(key: String, data: NSData?) -> Bool {
        guard let safeData = data else {
            return false
        }
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: oldKeychainIndetifier as AnyObject,
            kSecAttrAccount: key as AnyObject,
            kSecValueData: safeData
            ] as [NSString: AnyObject]
        
        let result = SecItemAdd(query as CFDictionary, nil)
        
        return result == errSecSuccess
    }
    
    class func delete(key: String) -> Bool {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: oldKeychainIndetifier as AnyObject,
            kSecAttrAccount: key as AnyObject
            ] as [NSString: AnyObject]
        
        let result = SecItemDelete(query as CFDictionary)
        
        return result == errSecSuccess
    }
}
