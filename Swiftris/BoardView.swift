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

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        drawBackground()
        drawCells()
    }

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
        return CGSize(width: CGFloat(gridSize.width) * cellSize.width + 1, height: CGFloat(gridSize.height) * cellSize.height + 1)
    }
    
    func drawBackground() {
        NSColor(calibratedRed: 0.5, green: 1.0, blue: 0.5, alpha: 1.0).setFill()
        NSBezierPath(rect: self.bounds).fill()
    }
    
    func drawCells() {
        if let dataSource = self.dataSource? {
            gridSize.enumerateGrids { (position: Point) in
                let colorIndex = dataSource.getColorIndexOfBoardView(self, position: position)
                self.drawCellAtPosition(position, colorIndex: colorIndex)
            }
        }
    }

    func drawCellAtPosition(position: Point, colorIndex: Int) {
        var point = displayPointFromGridPosition(position)
        var color = colorForIndex(colorIndex)
        
        drawCellAtPoint(point, color: color)
    }
    
    func colorForIndex(index: Int) -> NSColor {
        var colorDict = [
            0 : NSColor(calibratedRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
            1 : NSColor(calibratedRed: 0.0, green: 0.5, blue: 1.0, alpha: 1.0),
            2 : NSColor(calibratedRed: 1.0, green: 0.5, blue: 0.0, alpha: 1.0),
            3 : NSColor(calibratedRed: 0.5, green: 1.0, blue: 0.0, alpha: 1.0),
            4 : NSColor(calibratedRed: 1.0, green: 0.0, blue: 0.5, alpha: 1.0),
            5 : NSColor(calibratedRed: 0.0, green: 1.0, blue: 0.5, alpha: 1.0),
            6 : NSColor(calibratedRed: 0.5, green: 0.0, blue: 1.0, alpha: 1.0),
            7 : NSColor(calibratedRed: 0.5, green: 1.0, blue: 1.0, alpha: 1.0),
        ]
        var color: NSColor? = colorDict[index];
        
        if let result = color? {
            return result
        } else {
            return NSColor(white: 1.0, alpha: 1.0)
        }
    }
    
    func displayPointFromGridPosition(position: Point) -> CGPoint {
        return CGPoint(x: CGFloat(position.x) * cellSize.width + 1, y: CGFloat(position.y) * cellSize.height + 1)
    }
    
    func drawCellAtPoint(point: CGPoint, color: NSColor) {
        var halftone = color.halftone()

        halftone.setFill()
        NSBezierPath(rect: NSRect(x: point.x, y: point.y, width: cellSize.width - 1, height: cellSize.height - 1)).fill()
        color.setFill()
        NSBezierPath(rect: NSRect(x: point.x + 1, y: point.y + 1, width: cellSize.width - 3, height: cellSize.height - 3)).fill()
    }
}