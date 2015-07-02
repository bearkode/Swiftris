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

    @IBOutlet var window: NSWindow?
    
    let mainViewController = MainViewController(nibName: "MainViewController", bundle: NSBundle.mainBundle())

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        setupMainViewController()
    }

    func applicationWillTerminate(aNotification: NSNotification) {

    }
    
    func setupMainViewController() {
        if let mainView = mainViewController?.view,
           let contentView = window?.contentView {
            contentView.addSubview(mainView)
            mainView.frame = contentView.bounds
            
            window?.makeFirstResponder(mainView)
        }
    }
    
}

