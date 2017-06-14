//
//  HomeViewModel.swift
//  TVMed
//
//  Created by Vinicius Albino on 06/06/17.
//  Copyright © 2017 Vinicius Albino. All rights reserved.
//

import Foundation

protocol HomeDelegate: class {
    func contentDidFinishedLoading(success: Bool)
}

class HomeViewModel: NSObject {
    
    weak var delegate: HomeDelegate?
    private var midias = [MidiaPromotion]()
    private var currentMidia: MidiaPromotion?
    
    init(delegate: HomeDelegate) {
        self.delegate = delegate
    }
    
    func loadMeusProdutos() {
        let request = OrdersRequest()
        request.request { content, error in
            guard error == nil, let midias = content else {
                self.delegate?.contentDidFinishedLoading(success: false)
                return
            }
            self.midias = midias
            self.delegate?.contentDidFinishedLoading(success: true)
        }
    }
    
    func checkValiToken(callback: @escaping (Bool) -> () ) {
        let request = LoginRequest()
        request.validateToken { succes in
            callback(succes)
        }
    }
    
    func numberOfItensInSection() -> Int {
        return self.midias.count
    }
    
    func getMidias() -> [MidiaPromotion] {
        return self.midias
    }
}
