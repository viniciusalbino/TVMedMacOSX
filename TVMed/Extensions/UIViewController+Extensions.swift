//
//  UIViewController+Extensions.swift
//  TVMed
//
//  Created by Vinicius Albino on 19/03/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation
import Cocoa

extension NSViewController {
    
    func presentAlertWithTitle(title: String, message: String) {
        let alertController = NSAlert()
        alertController.messageText = title
        alertController.informativeText = message
        alertController.alertStyle = .warning
        alertController.addButton(withTitle: "OK")
        alertController.runModal()
    }
    
    func startLoading() {
//        SVProgressHUD.setDefaultStyle(.light)
//        SVProgressHUD.show()
    }
    
    func stopLoading() {
//        SVProgressHUD.dismiss()
    }
    
//    func addLogo() {
//        
//        let image = UIImage(named: "logo")
//        let imageView = UIImageView(image: image)
//        imageView.contentMode = .scaleAspectFit
//        self.navigationItem.titleView = imageView
//    }
}
