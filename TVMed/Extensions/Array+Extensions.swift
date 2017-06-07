//
//  Array+Extensions.swift
//  TVMed
//
//  Created by Vinicius Albino on 23/02/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation

extension Array {
    func object(index: Int) -> Element? {
        if index >= 0 && index < self.count {
            return self[index]
        }
        return nil
    }
    
}
