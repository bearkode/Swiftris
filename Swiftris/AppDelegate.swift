/*
 *  AppDelegate.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa


class AppDelegate: NSObject, NSApplicationDelegate
{
    @IBOutlet var window: NSWindow
    
    var gameViewController: GameViewController?
    
    
    init() {
    
    }
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        gameViewController = GameViewController(nibName: nil, bundle: nil)

        if let gameView = gameViewController?.view {
            let contentView = window.contentView as NSView
            
            contentView.addSubview(gameView)
            gameView.frame = contentView.bounds
        }
    }


    func applicationWillTerminate(aNotification: NSNotification?) {

    }
}

