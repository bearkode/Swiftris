/*
 *  MainView.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import AppKit
import Logic


protocol KeyboardEventDelegate: class {
    
    func eventOnView(_ view: NSView, didKeyDown keyCode: KeyCode)

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

    override func keyDown(with theEvent: NSEvent) {
        if let keyCode = KeyCode(rawValue: theEvent.keyCode) {
            self.delegate?.eventOnView(self, didKeyDown: keyCode)
        }
    }

}
