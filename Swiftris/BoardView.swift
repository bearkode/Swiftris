/*
 *  BoardView.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 20..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa


protocol BoardViewDataSource {

    func getCellSizeOfBoardView(boardView: BoardView) -> CGSize!
    func getGridSizeOfBoardView(boardView: BoardView) -> CGSize!
    
}


class BoardView: NSView {
    
    var dataSource: BoardViewDataSource? {
        didSet {
            reload()
        }
    }
    
    init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        var backgroundColor = NSColor(calibratedRed: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)
        var bezierPath      = NSBezierPath(rect: self.bounds)
        
        backgroundColor.setFill()
        bezierPath.fill()
    }
    
    func reload() {
        updateGridSize()
        updateCellSize()
        updateFrameSize()
    }
    
    /*
     *  Privates
     */

    var gridSize: CGSize = CGSize()
    var cellSize: CGSize = CGSize()
    
    func updateGridSize() {
        if let dataSource = self.dataSource? {
            gridSize = dataSource.getGridSizeOfBoardView(self)
        }
    }
    
    func updateCellSize() {
        if let dataSource = self.dataSource? {
            cellSize = dataSource.getCellSizeOfBoardView(self)
        }
    }
    
    func updateFrameSize() {
        setFrameSize(getFrameSizeWithGridSize(gridSize, cellSize: cellSize))
    }
    
    func getFrameSizeWithGridSize(gridSize: CGSize, cellSize: CGSize) -> CGSize! {
        return CGSize(width: gridSize.width * cellSize.width, height: gridSize.height * cellSize.height)
    }
    
}