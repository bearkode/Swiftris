/*
 *  Board.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 20..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class Board: DirtyCheckable {

    // MARK: - init

    init(size boardSize: GridSize) {
        self.grid = Grid(size: boardSize)
    }

    // MARK: - internal

    let grid: Grid
    var dirty = true
    var gridSize: GridSize {
        return self.grid.size
    }

    func reset() {
        self.grid.reset()
        self.dirty = true
    }
    
    func value(at position: Point) -> Int {
        return self.grid[position]
    }
    
    func isOverlapped(with block: Block, at position: Point) -> Bool {
        return self.grid.isOverlapped(withGrid: block.currentShape, position: position)
    }
    
    func isPossible(at position: Point, withBlock block: Block) -> Bool {
        return self.isPossible(at: position, withGrid: block.currentShape)
    }
    
    func isPossible(at position: Point, withGrid grid: Grid) -> Bool {
        return !self.grid.isOverlapped(withGrid: grid, position: position)
    }
    
    func immobilze(block: Block) {
        self.grid.copy(from: block.currentShape, position: block.position)
        self.dirty = true
    }
    
    func deleteFullRow() {
        self.grid.enumerateRowsFromTop { (row: Int) in
            if self.grid.isFull(row: row) {
                self.grid.compress(rowOver: row)
                self.deleteFullRow()
            }
        }
    }

}
