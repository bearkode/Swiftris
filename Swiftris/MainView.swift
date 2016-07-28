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
    case up = 126
    case down = 125
    case left = 123
    case right = 124
}


protocol KeyboardEventDelegate: class {
    
    func eventOnView(_ view: NSView, didKeyDown keyCode: BKKeyCode)

}


class MainView: NSView {
    
    weak var delegate: KeyboardEventDelegate?

    override var acceptsFirstResponder: Bool {
        return true
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSColor(calibratedRed: 1.0, green: 0.5, blue: 0.5, alpha: 1.0).setFill()
        NSBezierPath(rect: self.bounds).fill()
    }

    override func keyDown(_ theEvent: NSEvent) {
        if let keyCode = BKKeyCode(rawValue: theEvent.keyCode) {
            self.delegate?.eventOnView(self, didKeyDown: keyCode)
        }
    }

}
