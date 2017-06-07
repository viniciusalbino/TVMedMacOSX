//
//  HeaderBuilder.swift
//  TVMed
//
//  Created by Vinicius Albino on 26/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation

class HeaderBuilder {
    internal let tokenLocalService =  TokenPersister()
    
    internal var defaultHeader: [String: String] {
        return  [
            "Accept": "application/json",
            "Content-Type" : "application/json"
        ]
    }
    
    internal func headerAttributes(token: UserToken?) -> [String: String] {
        var header = defaultHeader
        if let userToken = token {
            header["Authorization"] = userToken.tokenApiFormat()
        }
        _ = header.addDictionary(dictionaryToAppend: LanguageHeader().getHeader())
        
        return header
    }
    
    func buildHeader(completion: @escaping ([String : String]) -> Void) {
        tokenLocalService.query { (token: UserToken?) in
            let headers = self.headerAttributes(token: token)
            completion(headers)
        }
    }
    
    func GET(url: String, params: [String: AnyObject]?, callback: @escaping DefaultCallBackClosure) {
        buildHeader { defaultHeaders in
            BaseRequest().GET(url: url, params: params, headers: defaultHeaders, callback: callback)
        }
    }
    
    func POST(url: String, params: [String: Any]?, headers: [String: String], callback: @escaping DefaultCallBackClosure) {
        buildHeader { defaultHeaders in
            BaseRequest().POST(url: url, params: params, headers: defaultHeaders, callback: callback)
        }
    }
}
