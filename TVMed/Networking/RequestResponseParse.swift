//
//  RequestResponseParse.swift
//  Zazcar
//
//  Created by Vinicius Albino on 06/01/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation

protocol RequestResponseParse {
    func parseJSON(json: JSONDictionary?, errorType: ErrorTypeApp?) -> (json: JSONDictionary?, errorType: ErrorTypeApp?)
}

extension RequestResponseParse {
    func parseJSON(json: JSONDictionary?, errorType: ErrorTypeApp?) -> (json: JSONDictionary?, errorType: ErrorTypeApp?) {
        guard let unwrappedJSON = json else {
            return (json, errorType)
        }
        return (unwrappedJSON, errorType)
    }
}
