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
    @IBOutlet weak var loadingView: NSProgressIndicator!
    @IBOutlet weak var cancelButton: NSButton!
    
    lazy var viewModel: LoginViewModel = LoginViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = true
    }
    
    override func startLoading() {
        loadingView.isHidden = false
        loadingView.startAnimation(self)
        loginButton.isEnabled = false
        passwordTextField.isEnabled = false
        emailTextField.isEnabled = false
        cancelButton.isEnabled = false
    }
    
    override func stopLoading() {
        loadingView.stopAnimation(self)
        loadingView.isHidden = true
        loginButton.isEnabled = true
        passwordTextField.isEnabled = true
        emailTextField.isEnabled = true
        cancelButton.isEnabled = true
    }
    
    func contentDidFinishedLoading(success: Bool) {
        stopLoading()
        guard success else {
            presentLoginIvalidAlert()
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
        let alert = NSAlert.init()
        alert.messageText = "Aviso"
        alert.informativeText = "Usuário ou senha inválidos"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}
