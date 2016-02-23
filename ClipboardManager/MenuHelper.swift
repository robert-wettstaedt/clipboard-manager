//
//  MenuHelper.swift
//  ClipboardManager
//
//  Created by Robert Wettstädt on 09/02/15.
//  Copyright (c) 2015 Robert Wettstädt. All rights reserved.
//

import Cocoa
import AppKit


class MenuHelper: NSObject {
    
    var pbHelper: PasteboardHelper
    var launcher: LaunchAtStartup
    
    let maxItems = 20
    
    var statusBar = NSStatusBar.systemStatusBar()
    var statusBarItem = NSStatusItem()
    var menu = NSMenu()
    var history = [String]()
    
    init(pbHelper: PasteboardHelper) {
        self.pbHelper = pbHelper
        launcher = LaunchAtStartup()
        statusBarItem = statusBar.statusItemWithLength(-1)
        statusBarItem.menu = menu
        statusBarItem.title = ""
        let path = NSBundle.mainBundle().resourcePath
        println(path)
        if let image = NSImage(named: "clip16x16") {
            image.setTemplate(true)
            statusBarItem.image = image
        } else {
            statusBarItem.title = "CM"
        }
        
        super.init()
        
        initDefaultItems()
    }
    
    func redraw(newPasteBoardItem item: String) {
        if history.count == 0 || history[0] != item {
            history.insert(item, atIndex: 0)
            var menuItem = NSMenuItem()
            menuItem.title = item
            if countElements(item) > 25 {
                menuItem.title = item.substringToIndex(advance(item.startIndex, 25))
            }
            menuItem.action = Selector("copyContent:")
            menuItem.target = self
            menuItem.keyEquivalent = ""
            menu.insertItem(menuItem, atIndex: 0)
        }
        
        if history.count > maxItems {
            history.removeAtIndex(maxItems)
            menu.removeItemAtIndex(maxItems)
        }
    }
    
    func initDefaultItems() {
        var menuItem = NSMenuItem()
        menuItem.title = "Quit"
        menuItem.action = Selector("quit:")
        menuItem.target = self
        menuItem.keyEquivalent = ""
        menu.insertItem(menuItem, atIndex: 0)
        
        menuItem = NSMenuItem()
        menuItem.title = "Launch at startup"
        menuItem.action = Selector("toggleLaunch:")
        menuItem.target = self
        if launcher.applicationIsInStartUpItems() {
            menuItem.state = 1
        } else {
            menuItem.state = 0
        }
        menuItem.keyEquivalent = ""
        menu.insertItem(menuItem, atIndex: 0)
        
        menu.insertItem(NSMenuItem.separatorItem(), atIndex: 0)
    }
    
    
    func copyContent(sender: AnyObject) {
        let index = menu.indexOfItemWithTitle((sender as NSMenuItem).title)
        pbHelper.setPasteboard(history[index])
    }
    
    func toggleLaunch(sender: AnyObject) {
        launcher.toggleLaunchAtStartup()
        
        if launcher.applicationIsInStartUpItems() {
            (sender as NSMenuItem).state = 1
        } else {
            (sender as NSMenuItem).state = 0
        }

    }
    
    func quit(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
}