/*
 *  Board.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 20..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


internal class Board: BoardProtocol, DirtyCheckable {

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
        return self.grid.isOverlapped(withGrid: block.currentShape, position: position)
    }

    internal func isPossible(at position: Point, withGrid grid: Grid<Int>) -> Bool {
        let pointsHasValue = Set(grid.pointsHasValue.map { $0 + position })

        guard self.grid.size.validate(points: pointsHasValue) else {
            return false
        }

        return pointsHasValue.isDisjoint(with: self.grid.pointsHasValue) ? true : false
    }

    internal func immobilze(block: Block) {
        self.grid.copy(from: block.currentShape, position: block.position)
        self.dirty = true
    }

    internal func deleteFullRow() {
        self.grid.rows.forEach {
            if $0.isFull {
                self.grid.compress(rowOver: $0.index)
                self.deleteFullRow()
            }
        }
    }

}
