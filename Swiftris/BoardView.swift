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
    func getColorIndexOfBoardView(boardView: BoardView, position: Point) -> Int!
    
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
        drawCells()
    }
    
    func reload() {
        updateGridSize()
        updateCellSize()
        updateFrameSize()
        setNeedsDisplayInRect(self.bounds)
    }
    
    /*
     *  Privates
     */

    var gridSize = GridSize()
    var cellSize = CGSize()
    
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
        var frameSize = getFrameSizeWithGridSize(gridSize, cellSize: cellSize)
        setFrameSize(frameSize)
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
    
    func drawCells() {
        if let dataSource = self.dataSource? {
            gridSize.enumerateGrids { (position: Point) in
                let colorIndex = dataSource.getColorIndexOfBoardView(self, position: position)
                self.drawCellAtPosition(position, color: colorIndex)
            }
        }
    }

    func drawCellAtPosition(position: Point, color: Int) {
        
        var x = CGFloat(position.x) * cellSize.width
        var y = CGFloat(position.y) * cellSize.height
        var bezierPath = NSBezierPath(rect: NSRect(x: x, y: y, width: cellSize.width, height: cellSize.height))
        var cellColor = NSColor(calibratedRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cellColor.setFill()
        bezierPath.fill()
        
        x++
        y++
        bezierPath = NSBezierPath(rect: NSRect(x: x, y: y, width: cellSize.width - 2, height: cellSize.height - 2))
        cellColor = NSColor(calibratedRed: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
        cellColor.setFill()
        bezierPath.fill()
    }
}