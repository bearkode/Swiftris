/*
 *  BoardView.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 20..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa


protocol BoardViewDataSource: class {

    func cellSizeOfBoardView(boardView: BoardView) -> CGSize
    func gridSizeOfBoardView(boardView: BoardView) -> GridSize
    func colorIndexOfBoardView(boardView: BoardView, position: Point) -> Int
    
}


class BoardView: NSView {
    
    weak var dataSource: BoardViewDataSource? {
        didSet {
            reload()
        }
    }
    
    override var flipped: Bool {
        get {
            return true
        }
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
        if let dataSource = self.dataSource {
            gridSize = dataSource.gridSizeOfBoardView(self)
        }
    }
    
    func updateCellSize() {
        if let dataSource = self.dataSource {
            cellSize = dataSource.cellSizeOfBoardView(self)
        }
    }
    
    func updateFrameSize() {
        let frameSize = getFrameSizeWithGridSize(gridSize, cellSize: cellSize)
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
        if let dataSource = self.dataSource {
            gridSize.enumerateGrids { (position: Point) in
                let colorIndex = dataSource.colorIndexOfBoardView(self, position: position)
                self.drawCellAtPosition(position, colorIndex: colorIndex)
            }
        }
    }

    func drawCellAtPosition(position: Point, colorIndex: Int) {
        let point = displayPointFromGridPosition(position)
        let color = NSColor.colorForIndex(colorIndex)
        
        drawCellAtPoint(point, color: color)
    }
    
    func displayPointFromGridPosition(position: Point) -> CGPoint {
        return CGPoint(x: CGFloat(position.x) * cellSize.width + 1, y: CGFloat(position.y) * cellSize.height + 1)
    }
    
    func drawCellAtPoint(point: CGPoint, color: NSColor) {
        color.halftone().setFill()
        NSBezierPath(rect: NSRect(x: point.x, y: point.y, width: cellSize.width - 1, height: cellSize.height - 1)).fill()
        color.setFill()
        NSBezierPath(rect: NSRect(x: point.x + 1, y: point.y + 1, width: cellSize.width - 3, height: cellSize.height - 3)).fill()
    }
    
}