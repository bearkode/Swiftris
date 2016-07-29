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

    func cellSizeOfBoardView(_ boardView: BoardView) -> CGSize
    func gridSizeOfBoardView(_ boardView: BoardView) -> GridSize
    func colorIndexOfBoardView(_ boardView: BoardView, position: Point) -> Int
    
}


class BoardView: NSView {
    
    weak var dataSource: BoardViewDataSource? {
        didSet {
            self.reload()
        }
    }
    
    //  MARK: - override
    override var isFlipped: Bool {
        return true
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        self.drawBackground()
        self.drawCells()
    }

    //  MARK: -
    func reload() {
        self.updateGridSize()
        self.updateCellSize()
        self.updateFrameSize()
        
        setNeedsDisplay(self.bounds)
    }
    
    // MARK: - Private
    private var gridSize = GridSize()
    private var cellSize = CGSize()
 
}


private extension BoardView {

    private func updateGridSize() {
        self.gridSize = self.dataSource?.gridSizeOfBoardView(self) ?? self.gridSize
    }
    
    private func updateCellSize() {
        self.cellSize = self.dataSource?.cellSizeOfBoardView(self) ?? self.cellSize
    }
    
    private func updateFrameSize() {
        self.setFrameSize(self.suitableFrameSize)
    }
    
    private func drawBackground() {
        NSColor(calibratedRed: 0.5, green: 1.0, blue: 0.5, alpha: 1.0).setFill()
        NSBezierPath(rect: self.bounds).fill()
    }
    
    private func drawCells() {
        guard let dataSource = self.dataSource else {
            return
        }
        
        self.gridSize.enumerate { (position: Point) in
            let colorIndex = dataSource.colorIndexOfBoardView(self, position: position)
            self.drawCell(at: position, colorIndex: colorIndex)
        }
    }
    
    private func drawCell(at position: Point, colorIndex: Int) {
        let point = self.displayPoint(fromGridPosition: position)
        let color = NSColor.color(forIndex: colorIndex)
        
        self.drawCellAtPoint(point, color: color)
    }
    
    private func displayPoint(fromGridPosition position: Point) -> CGPoint {
        return CGPoint(x: CGFloat(position.x) * self.cellSize.width + 1, y: CGFloat(position.y) * self.cellSize.height + 1)
    }
    
    private func drawCellAtPoint(_ point: CGPoint, color: NSColor) {
        color.halftone().setFill()
        NSBezierPath(rect: NSRect(x: point.x, y: point.y, width: cellSize.width - 1, height: cellSize.height - 1)).fill()
        color.setFill()
        NSBezierPath(rect: NSRect(x: point.x + 1, y: point.y + 1, width: cellSize.width - 3, height: cellSize.height - 3)).fill()
    }
    
    private var suitableFrameSize: CGSize {
        return CGSize(width: CGFloat(self.gridSize.width) * self.cellSize.width + 1, height: CGFloat(self.gridSize.height) * self.cellSize.height + 1)
    }

}
