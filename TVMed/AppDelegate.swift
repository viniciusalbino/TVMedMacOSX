//
//  AppDelegate.swift
//  TVMed
//
//  Created by Vinicius Albino on 05/06/17.
//  Copyright © 2017 Vinicius Albino. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
         RealmToGroupsMigrator.migrateRealm()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

