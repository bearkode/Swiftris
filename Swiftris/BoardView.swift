/*
 *  BoardView.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 20..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa
import Logic


protocol BoardViewDelegate: AnyObject {

    func boardView(didChangeFrame frame: CGRect)

}


protocol BoardViewDataSource: AnyObject {

    func cellSizeOfBoardView(_ boardView: BoardView) -> CGSize
    func gridSizeOfBoardView(_ boardView: BoardView) -> Size
    func colorIndexOfBoardView(_ boardView: BoardView, position: Point) -> Int

}


class BoardView: NSView {

    // MARK: - override

    override var isFlipped: Bool {
        return true
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        self.drawBackground()
        self.drawCells()
    }

    // MARK: - public

    weak var delegate: BoardViewDelegate? {
        didSet {
            self.updateFrameSize()
        }
    }
    weak var dataSource: BoardViewDataSource? {
        didSet {
            self.reload()
        }
    }

    func reload() {
        self.updateGridSize()
        self.updateCellSize()

        setNeedsDisplay(self.bounds)
    }

    var outterCellRect: (CGPoint) -> NSRect = { _ in .zero }
    var innerCellRect: (CGPoint) -> NSRect = { _ in .zero }

    // MARK: - Private

    private var gridSize = Size()
    private var cellSize = CGSize() {
        didSet {
            func cellRect(point: CGPoint, size: CGSize, depth: CGFloat) -> NSRect {
                return NSRect(x: point.x + depth,
                              y: point.y + depth,
                              width: size.width - (depth * 2 + 1),
                              height: size.height - (depth * 2 + 1))
            }

            let cellSize = self.cellSize
            self.outterCellRect = { point in
                cellRect(point: point, size: cellSize, depth: 0)
            }
            self.innerCellRect = { point in
                cellRect(point: point, size: cellSize, depth: 1)
            }
        }
    }

}


private extension BoardView {

    func updateGridSize() {
        self.gridSize = self.dataSource?.gridSizeOfBoardView(self) ?? self.gridSize
    }

    func updateCellSize() {
        self.cellSize = self.dataSource?.cellSizeOfBoardView(self) ?? self.cellSize
    }

    func updateFrameSize() {
        self.setFrameSize(self.suitableFrameSize)
        self.delegate?.boardView(didChangeFrame: self.frame)
    }

    func drawBackground() {
        NSColor(calibratedRed: 0.5, green: 1.0, blue: 0.5, alpha: 1.0).setFill()
        NSBezierPath(rect: self.bounds).fill()
    }

    func drawCells() {
        self.gridSize.points.forEach { position in
            (self.dataSource?.colorIndexOfBoardView(self, position: position)).map {
                self.drawCell(at: position, colorIndex: $0)
            }
        }
    }

    func drawCell(at position: Point, colorIndex: Int) {
        let point = self.displayPoint(fromGridPosition: position)
        let color = NSColor.color(forIndex: colorIndex)

        self.drawCellAtPoint(point, color: color)
    }

    func displayPoint(fromGridPosition position: Point) -> CGPoint {
        let x = CGFloat(position.x) * self.cellSize.width + 1
        let y = CGFloat(position.y) * self.cellSize.height + 1
        return CGPoint(x: x, y: y)
    }

    func drawCellAtPoint(_ point: CGPoint, color: NSColor) {
        color.halftone().setFill()
        NSBezierPath(rect: self.outterCellRect(point)).fill()
        color.setFill()
        NSBezierPath(rect: self.innerCellRect(point)).fill()
    }

    var suitableFrameSize: CGSize {
        let width = CGFloat(self.gridSize.width) * self.cellSize.width + 1
        let height = CGFloat(self.gridSize.height) * self.cellSize.height + 1
        return CGSize(width: width, height: height)
    }

}
