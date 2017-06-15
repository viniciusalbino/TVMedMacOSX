//
//  CollectionViewItem.swift
//  TVMed
//
//  Created by Vinicius Albino on 14/06/17.
//  Copyright © 2017 Vinicius Albino. All rights reserved.
//

import Cocoa

class CollectionViewItem: NSCollectionViewItem {

    @IBOutlet weak var titleLabel: NSTextField!
    
    func fill(title: String) {
        titleLabel.stringValue = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
        titleLabel.maximumNumberOfLines = 10
        titleLabel.usesSingleLineMode = false
    }
    
}
