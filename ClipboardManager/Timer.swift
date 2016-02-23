//
//  Timer.swift
//  ClipboardManager
//
//  Created by Robert Wettstädt on 09/02/15.
//  Copyright (c) 2015 Robert Wettstädt. All rights reserved.
//

import Cocoa

class Timer: NSObject {
    
    var pbHelper: PasteboardHelper
    var timer = NSTimer()
    var menu: MenuHelper
    
    init(menu: MenuHelper, pbHelper: PasteboardHelper) {
        self.pbHelper = pbHelper
        self.menu = menu
        super.init()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update:"), userInfo: nil, repeats: true)
        update(true)
    }
    
    func update(possibleBoolean: AnyObject) {
        if (pbHelper.changeCount != pbHelper.ownChangeCount) || possibleBoolean is Bool {
            if let item = pbHelper.currentItem {
                menu.redraw(newPasteBoardItem: item)
                pbHelper.resetCount()
            }
        }
    }
    
}