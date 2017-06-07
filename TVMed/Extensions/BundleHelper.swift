//
//  BundleHelper.swift
//  Shoestock
//
//  Created by Vinicius de Moura Albino on 07/03/17.
//  Copyright © 2017 Netshoes. All rights reserved.
//

import Foundation

class BundleHelper: NSObject {
    
    class func bundleIdentifier() -> String {
        guard let dict = Bundle.main.infoDictionary, let identifier = dict["CFBundleIdentifier"] as? String else {
            return "br.com.realmNetshoes"
        }
        return identifier
    }
}
