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
    
    let mainViewController = MainViewController(nibName: "MainViewController", bundle: Bundle.main)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.setupMainViewController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }
    
    func setupMainViewController() {
        guard let mainView = self.mainViewController?.view,
              let window = self.window,
              let contentView = window.contentView else {
            return
        }

        contentView.addSubview(mainView)
        mainView.frame = contentView.bounds
        window.makeFirstResponder(mainView)
    }
    
}
