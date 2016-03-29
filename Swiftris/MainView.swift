/*
 *  MainView.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import AppKit


enum BKKeyCode: UInt16 {
    case Up = 126
    case Down = 125
    case Left = 123
    case Right = 124
}


protocol KeyboardEventDelegate: class {
    
    func eventOnView(view: NSView, didKeyDown keyCode: BKKeyCode)

}


class MainView: NSView {
    
    weak var delegate: KeyboardEventDelegate?

    override var acceptsFirstResponder: Bool {
        return true
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        NSColor(calibratedRed: 1.0, green: 0.5, blue: 0.5, alpha: 1.0).setFill()
        NSBezierPath(rect: self.bounds).fill()
    }

    override func keyDown(theEvent: NSEvent) {
        if let keyCode = BKKeyCode(rawValue: theEvent.keyCode) {
            delegate?.eventOnView(self, didKeyDown: keyCode)
        }
    }

}
