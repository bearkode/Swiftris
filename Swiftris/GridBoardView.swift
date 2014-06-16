/*
 *  GridBoardView.swift
 *  Swiftris
 *
 *  Created by cgkim on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa


class GridBoardView: NSView {

    init(frame: NSRect) {
        super.init(frame: frame)
        /*  Initialization code here.  */
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        var backgroundColor = NSColor(calibratedRed: 1.0, green: 0.5, blue: 0.5, alpha: 1.0)
        var bezierPath      = NSBezierPath(rect: self.bounds)

        backgroundColor.setFill()
        bezierPath.fill()
    }

}
