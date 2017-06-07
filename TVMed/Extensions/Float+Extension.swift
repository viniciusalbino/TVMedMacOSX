//
//  Float+Extension.swift
//  TVMed
//
//  Created by Vinicius Albino on 19/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation

extension Float {
    var currencyValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: (self / 1))) ?? ""
    }
}
