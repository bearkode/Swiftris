/*
 *  MainViewController.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa


class MainViewController: NSViewController, KeyboardEventDelegate {

    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        /*  Initialization code here.  */
        println("MainViewController init(nibName, bundle)")
    }

    init(coder: NSCoder!) {
        super.init(coder: coder)
        println("MainViewController init(coder)")
    }

    override func loadView() {
        super.loadView()
        
        println("MainViewController loadView")
        self.view.autoresizingMask = (NSAutoresizingMaskOptions.ViewWidthSizable | NSAutoresizingMaskOptions.ViewHeightSizable)
        
        var view = (self.view as MainView)
        view.delegage = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("MainViewController viewDidLoad")   //  TODO : 이거 왜 안불리지?
    }
    
    func didKeyDown(keyCode: CUnsignedShort) {
        println("didKeyDown = \(keyCode)")
        //  UP : 126
        //  DOWN : 125
        //  LEFT : 123
        //  RIGHT : 124
    }
}
