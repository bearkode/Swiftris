/*
 *  AppDelegate.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa


class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow
    
    var mainViewController: MainViewController?

    init() {
    
    }

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        mainViewController = MainViewController(nibName: "MainViewController", bundle: NSBundle.mainBundle())
        
        if let mainView = mainViewController?.view {
            window.contentView.addSubview(mainView)
            mainView.frame = window.contentView.bounds
        }
        
        var block1 = BlockType1()
        block1.debugPrint()
        println("")
        
        var block2 = BlockType2()
        block2.debugPrint()
        println("")

        var block3 = BlockType3()
        block3.debugPrint()
        println("")

        var block4 = BlockType4()
        block4.debugPrint()
    }

    func applicationWillTerminate(aNotification: NSNotification?) {

    }

}

