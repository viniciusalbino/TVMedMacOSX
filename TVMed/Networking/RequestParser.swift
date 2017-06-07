//
//  RequestParser.swift
//  Zattini
//
//  Created by Vinicius Albino John Morris on 11/26/15.
//  Copyright © 2015 Netshoes. All rights reserved.
//

import Foundation
import ObjectMapper

precedencegroup ExponentiativePrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator <*> :ExponentiativePrecedence

func <*> <T: Mappable>(json: [Any]?, type: T.Type) -> (object: [T]?, error: ErrorTypeApp?) {
    guard let array = json as? [JSONDictionary] else {
        return (nil, .parserError)
    }
    return (array.map { T(JSON: $0)! }, nil)
}

func <*> <T: Mappable>(json: Any?, type: T.Type) -> (object: T?, error: ErrorTypeApp?) {
    guard let json = json as? JSONDictionary else {
        return (nil, .parserError)
    }
    return (T(JSON: json), nil)
}

func <*> <T: Mappable>(json: JSONDictionary?, type: T.Type) -> (object: T?, error: ErrorTypeApp?) {
    guard let json = json else {
        return (nil, .parserError)
    }
    return (T(JSON: json), nil)
}

func <*> <T: Mappable>(json: [JSONDictionary]?, response: (type: T.Type, error: ErrorTypeApp?)) -> (object: [T]?, error: ErrorTypeApp?) {
    guard let array = json else {
        return (nil, response.error ?? .parserError)
    }
    return (array.map { T(JSON: $0)! }, nil)
}

func <*> <T: Mappable>(json: Any?, response: (type: T.Type, error: ErrorTypeApp?)) -> (object: T?, error: ErrorTypeApp?) {
    guard let json = json as? JSONDictionary else {
        return (nil, response.error ?? .parserError)
    }
    return (T(JSON: json), nil)
}

func <*> <T: Mappable>(json: JSONDictionary?, response: (type: T.Type, error: ErrorTypeApp?)) -> (object: T?, error: ErrorTypeApp?) {
    guard let json = json else {
        return (nil, response.error ?? .parserError)
    }
    return (T(JSON: json), nil)
}
