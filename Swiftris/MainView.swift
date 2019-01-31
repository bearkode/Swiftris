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
    
    // MARK: - override

    override var acceptsFirstResponder: Bool {
        return true
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSColor(calibratedRed: 1.0, green: 0.5, blue: 0.5, alpha: 1.0).setFill()
        NSBezierPath(rect: self.bounds).fill()
    }

    override func keyDown(with theEvent: NSEvent) {
        KeyCode(rawValue: theEvent.keyCode).map {
            self.delegate?.eventOnView(self, didKeyDown: $0)
        }
    }

    // MARK: - public

    weak var delegate: KeyboardEventDelegate?

}
