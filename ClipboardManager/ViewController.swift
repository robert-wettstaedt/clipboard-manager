//
//  ViewController.swift
//  ClipboardManager
//
//  Created by Robert Wettstädt on 09/02/15.
//  Copyright (c) 2015 Robert Wettstädt. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var label: NSTextField!
    let pb = NSPasteboard.generalPasteboard()
    var changeCount: Int = 0
    var timer = NSTimer()
    
    func update() {
        label.stringValue = pb.pasteboardItems![0].stringForType("public.utf8-plain-text")!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeCount = pb.changeCount
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

