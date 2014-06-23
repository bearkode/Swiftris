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
    func getGridSizeOfBoardView(boardView: BoardView) -> GridSize!
    func getColorIndexOfBoardView(boardView: BoardView, position: Point) -> Int
    
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
        
        drawBackground()
    }
    
    func reload() {
        updateGridSize()
        updateCellSize()
        updateFrameSize()
    }
    
    /*
     *  Privates
     */

    var gridSize: GridSize = GridSize(width: 0, height: 0)
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
    
    func getFrameSizeWithGridSize(gridSize: GridSize, cellSize: CGSize) -> CGSize! {
        return CGSize(width: CGFloat(gridSize.width) * cellSize.width, height: CGFloat(gridSize.height) * cellSize.height)
    }
    
    func drawBackground() {
        var backgroundColor = NSColor(calibratedRed: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)
        var bezierPath      = NSBezierPath(rect: self.bounds)
        
        backgroundColor.setFill()
        bezierPath.fill()
    }

    func drawCellAtPosition(position:Point, color:Int) {
    
    }
}