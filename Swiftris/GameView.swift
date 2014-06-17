/*
 *  GameView.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import AppKit


class GameView: NSView {
    
    var gridBoardView: GridBoardView?
    
    init(frame: NSRect) {
        super.init(frame: frame)
        /*  Initialization code here.  */
        
        gridBoardView = GridBoardView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        let bezierPath = NSBezierPath(rect: self.bounds)
        let color = NSColor(deviceRed: 0.7, green: 0.7, blue: 0.7, alpha: 1.0);
        
        color.setFill()
        bezierPath.fill()
    }

}
