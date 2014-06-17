/*
 *  MainView.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import AppKit


protocol KeyboardEventDelegate {
    
    func didKeyDown(keyCode: CUnsignedShort)
    
}


class MainView: NSView {
    
    var delegage: KeyboardEventDelegate?

    override var acceptsFirstResponder: Bool {
        get {
            return true
        }
    }

    init(frame: NSRect) {
        super.init(frame: frame)
    }

    init(coder: NSCoder!) {
        super.init(coder: coder)
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        var backgroundColor = NSColor(calibratedRed: 1.0, green: 0.5, blue: 0.5, alpha: 1.0)
        var bezierPath      = NSBezierPath(rect: self.bounds)
        
        backgroundColor.setFill()
        bezierPath.fill()
    }

    override func keyDown(theEvent: NSEvent!) {
        delegage?.didKeyDown(theEvent.keyCode)
    }

}
