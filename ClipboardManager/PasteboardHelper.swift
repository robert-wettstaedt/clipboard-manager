//
//  PasteboardHelper.swift
//  ClipboardManager
//
//  Created by Robert Wettstädt on 09/02/15.
//  Copyright (c) 2015 Robert Wettstädt. All rights reserved.
//

import Cocoa

class PasteboardHelper {
    
    let pb = NSPasteboard.generalPasteboard()
    var changeCount: Int {
        return pb.changeCount
    }
    var currentItem: String? {
        if pb.pasteboardItems!.count == 0 {
            return nil
        }
        if let item = pb.pasteboardItems![0].stringForType("public.utf8-plain-text") {
            return item
        }
        return nil
    }
    var ownChangeCount = 0
    
    init() {
        ownChangeCount = pb.changeCount
    }
    
    func resetCount() {
        ownChangeCount = pb.changeCount
    }
    
    func setPasteboard(item: String) {
        pb.clearContents()
        pb.setString(item, forType: NSStringPboardType)
    }
}