//
//  HeaderView.swift
//  TVMed
//
//  Created by Vinicius Albino on 14/06/17.
//  Copyright © 2017 Vinicius Albino. All rights reserved.
//

import Foundation
import Cocoa

class HeaderView: NSView {
    
    @IBOutlet weak var titleLabel: NSTextField!
    
    func fill(title: String) {
        titleLabel.stringValue = title
    }
}
