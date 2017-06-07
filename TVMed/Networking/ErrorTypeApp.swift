//
//  ErrorTypeApp.swift
//  TVMed
//
//  Created by Vinicius Albino on 21/02/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation

enum ErrorTypeApp: Error, Equatable {
    
    public static func == (lhs: ErrorTypeApp, rhs: ErrorTypeApp) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
    
    case parserError
    case networkError
    case apiError
    case invalidParam
    case invalidURL
    case expiredSession
    case customError(Error)
    //    case ServerErrorMessage(String)
    case forced
}
