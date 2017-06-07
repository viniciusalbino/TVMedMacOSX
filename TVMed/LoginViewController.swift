//
//  LoginViewController.swift
//  TVMed
//
//  Created by Vinicius Albino on 22/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import Cocoa

class LoginViewController: NSViewController, LoginDelegate {
    
    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var loginButton: NSButton!
    
    lazy var viewModel: LoginViewModel = LoginViewModel(delegate: self)
    
    func contentDidFinishedLoading(success: Bool) {
        stopLoading()
        guard success else {
//            presentLoginIvalidAlert()
            return
        }
        dismiss(self)
    }
    
    
    @IBAction func cancelLogin(_ sender: Any) {
        dismiss(self)
    }
    
    @IBAction func makeLogin(_ sender: Any) {
        guard emailTextField.stringValue.length() > 0, passwordTextField.stringValue.length() > 0 else {
            presentLoginIvalidAlert()
            return
        }
        guard viewModel.validatesLogin(password: passwordTextField.stringValue, email: emailTextField.stringValue) else {
            presentLoginIvalidAlert()
            return
        }
        
        startLoading()
        viewModel.loginRequest(email: emailTextField.stringValue, password: passwordTextField.stringValue)
    }
    
    func presentLoginIvalidAlert() {
//        self.presentAlertWithTitle(title: "Aviso", message: "Usuário ou senha inválidos")
    }
}
