/*
 *  GameView.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import AppKit


class GameView: NSView
{
    override var acceptsFirstResponder: Bool {
        get {
            return true
        }
    }
    
    init(frame: NSRect) {
        super.init(frame: frame)
        /*  Initialization code here.  */
    }

    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        let bezierPath = NSBezierPath(rect: self.bounds)
        let color = NSColor(deviceRed: 0.7, green: 0.7, blue: 0.7, alpha: 1.0);
        
        color.setFill()
        bezierPath.fill()
    }
    
    
    override func keyDown(theEvent: NSEvent!) {
        println("keycode = \(theEvent.keyCode)")
    }
}
