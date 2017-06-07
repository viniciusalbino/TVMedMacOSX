//
//  UIColor+Extensions.swift
//  TVMed
//
//  Created by Vinicius de Moura Albino on 15/04/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import Cocoa

extension Bool {
    init(_ number: Int) {
        self.init(number as NSNumber)
    }
}

extension NSColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let sanitizedString = hexString
            .replacingOccurrences(of:" ", with: "")
            .replacingOccurrences(of:"#", with: "")
        
        var RGB = UInt32(0)
        Scanner(string: sanitizedString).scanHexInt32(&RGB)
        self.init(netHex: Int(RGB), alpha: alpha)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alphaValue: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alphaValue)
    }
    
    convenience init(netHex: Int, alpha: CGFloat = 1.0) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, alphaValue: alpha)
    }
}
