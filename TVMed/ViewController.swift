//
//  ViewController.swift
//  TVMed
//
//  Created by Vinicius Albino on 05/06/17.
//  Copyright © 2017 Vinicius Albino. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, HomeDelegate {

    lazy var viewModel: HomeViewModel = HomeViewModel(delegate:self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        validatesToken()
    }
    
    func validatesToken() {
        let tokenPersister = TokenPersister()
        tokenPersister.query { token in
            
            guard let userToken = token, !userToken.token.isEmpty else {
                return
            }
            
            self.viewModel.checkValiToken { success in
                
                guard !success else {
                    return
                }
                self.performSegue(withIdentifier: "presentLogin", sender: nil)
            }
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

