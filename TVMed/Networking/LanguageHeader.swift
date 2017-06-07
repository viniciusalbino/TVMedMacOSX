//
//  LanguageHeader.swift
//  TVMed
//
//  Created by Vinicius de Moura Albino on 11/04/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation

enum headerEnum:String {
    case portuguese = "pt-BR"
    case spanish = "es-ES"
    case english = "en-US"
    
    init(rawValue: String) {
        switch rawValue {
        case "es-EN":
            self = .english
        case "es-ES":
            self = .spanish
        default:
            self = .portuguese
        }
    }
}
class LanguageHeader {
    
    private let headerKey = "headerLanguage"
    
    func getHeader() -> [String: String] {
        guard let header = self.retrieveDefaultBaseUrl() else {
            return ["Accept-Language" : self.defaultBaseUrl()]
        }
        return ["Accept-Language" : header]
    }
    
    func changeHeaderLanguage(header: headerEnum) {
        self.saveDefaultBaseUrl(key: header.rawValue)
    }
    
    private func defaultBaseUrl() -> String {
        return headerEnum.portuguese.rawValue
    }
    
    private func saveDefaultBaseUrl(key:String) {
        UserDefaults.standard.setValue(key, forKey: headerKey)
        UserDefaults.standard.synchronize()
    }
    
    private func retrieveDefaultBaseUrl() -> String? {
        return UserDefaults.standard.string(forKey: headerKey)
    }
}
