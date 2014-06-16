/*
 *  GameViewController.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import AppKit


class GameViewController: NSViewController {

    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        /*  Initialization code here.  */
    }

    override func loadView() {
        self.view = GameView(frame: NSRect(x: 0, y: 0, width: 0, height: 0))    //  NSRectZero같은거 없나?
        self.view.autoresizingMask = (NSAutoresizingMaskOptions.ViewWidthSizable | NSAutoresizingMaskOptions.ViewHeightSizable)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        println("GameViewController viewDidLoad")
    }

}
