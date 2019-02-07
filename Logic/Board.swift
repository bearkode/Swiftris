/*
 *  Board.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 20..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


internal class Board: DirtyCheckable {

    // MARK: - init

    internal init(size boardSize: Size) {
        self.grid = Grid(size: boardSize)
    }

    // MARK: - internal

    internal let grid: Grid<Int>
    internal var dirty = true
    internal var gridSize: Size {
        return self.grid.size
    }

    internal func reset() {
        self.grid.reset()
        self.dirty = true
    }

    internal func value(at position: Point) -> Int? {
        return self.grid[position]
    }

    internal func isOverlapped(with block: Block, at position: Point) -> Bool {
        let pointHasValue = block.currentShape.pointsHasValue.map { $0 + position }
        let validPoints = pointHasValue.filter { self.grid.size.isValid(position: $0) }

        if pointHasValue.count != validPoints.count {
            return true
        }

        let canOverlap = pointHasValue.filter { self.grid[$0] == nil }

        return pointHasValue.count != canOverlap.count
    }

    internal func isPossible(at position: Point, withBlock block: Block) -> Bool {
        return self.isPossible(at: position, withGrid: block.currentShape)
    }

    internal func isPossible(at position: Point, withGrid grid: Grid<Int>) -> Bool {
        let pointHasValue = grid.pointsHasValue.map { $0 + position }
        let validPoints = pointHasValue.filter { self.grid.size.isValid(position: $0) }

        if pointHasValue.count != validPoints.count {
            return false
        }

        let canOverlap = pointHasValue.filter { self.grid[$0] == nil }

        return pointHasValue.count == canOverlap.count
    }

    internal func immobilze(block: Block) {
        self.grid.copy(from: block.currentShape, position: block.position)
        self.dirty = true
    }

    internal func deleteFullRow() {
        self.grid.enumerateRowsFromTop { (row: Int) in
            if self.grid.isFull(row: row) {
                self.grid.compress(rowOver: row)
                self.deleteFullRow()
            }
        }
    }

}
