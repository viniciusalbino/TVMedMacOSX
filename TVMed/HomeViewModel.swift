//
//  HomeViewModel.swift
//  TVMed
//
//  Created by Vinicius Albino on 06/06/17.
//  Copyright © 2017 Vinicius Albino. All rights reserved.
//

import Foundation

protocol HomeDelegate: class {
    
}

class HomeViewModel: NSObject {
    
    weak var delegate: HomeDelegate?
    
    init(delegate: HomeDelegate) {
        self.delegate = delegate
    }
    
    func checkValiToken(callback: @escaping (Bool) -> () ) {
        let request = LoginRequest()
        request.validateToken { succes in
            callback(succes)
        }
    }
}
