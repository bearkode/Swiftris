/*
 *  GameViewController.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import AppKit


class GameViewController: NSViewController, KeyboardEventDelegate {
    
    let logicController = GameLogicController()

    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        println("nibName = \(nibNameOrNil), nibBundleOrNil = \(nibBundleOrNil)")
    }

    override func loadView() {
        
        var gameView = GameView(frame: NSRect(x: 0, y: 0, width: 0, height: 0))    //  NSRectZero같은거 없나?
        
//        gameView.delegate = self
        
        self.view = gameView
        self.view.autoresizingMask = (NSAutoresizingMaskOptions.ViewWidthSizable | NSAutoresizingMaskOptions.ViewHeightSizable)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        println("GameViewController viewDidLoad")
    }

    func didKeyDown(keyCode: CUnsignedShort) {
        println("keydown = \(keyCode)")
    }
}
