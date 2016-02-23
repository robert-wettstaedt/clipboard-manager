//
//  AppDelegate.swift
//  ClipboardManager
//
//  Created by Robert Wettstädt on 09/02/15.
//  Copyright (c) 2015 Robert Wettstädt. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        let pbHelper = PasteboardHelper()
        let menu = MenuHelper(pbHelper: pbHelper)
        let timer = Timer(menu: menu, pbHelper: pbHelper)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        println(aNotification)
    }

}

