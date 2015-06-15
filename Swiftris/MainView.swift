/*
 *  MainView.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import AppKit


protocol KeyboardEventDelegate: class {
    
    func eventOnView(view: NSView, didKeyDown keyCode: CUnsignedShort)

}


class MainView: NSView {
    
    weak var delegate: KeyboardEventDelegate?    /*  Can't use weak. It looks like a bug.  */

    override var acceptsFirstResponder: Bool {
        get {
            return true
        }
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        NSColor(calibratedRed: 1.0, green: 0.5, blue: 0.5, alpha: 1.0).setFill()
        NSBezierPath(rect: self.bounds).fill()
    }

    override func keyDown(theEvent: NSEvent) {
        delegate?.eventOnView(self, didKeyDown: theEvent.keyCode)
    }

}
