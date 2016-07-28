/*
 *  Board.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 20..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class Board {
    
    let grid: Grid
    var dirty = true
    var gridSize: GridSize {
        return self.grid.size
    }

    init(size boardSize: GridSize) {
        self.grid = Grid(width: boardSize.width, height: boardSize.height)
    }
    
    //  MARK: -
    func valueAtPosition(_ position: Point) -> Int {
        return self.grid[position]
    }
    
    func isOverlappedAtPosition(_ position: Point, block: Block) -> Bool {
        return self.grid.isOverlappedGrid(block.currentShape, position: position)
    }
    
    func isPossiblePosition(_ position: Point, block: Block) -> Bool {
        return self.isPossiblePosition(position, grid: block.currentShape)
    }
    
    func isPossiblePosition(_ position: Point, grid: Grid) -> Bool {
        return !self.grid.isOverlappedGrid(grid, position: position)
    }
    
    func immobilzeBlock(_ block: Block) {
        self.grid.copyGrid(block.currentShape, position: block.position)
        self.dirty = true
    }
    
    func deleteFullRow() {
        for i in stride(from: (self.grid.size.height - 1), through: 0, by: -1) {
            if self.grid.isFullRow(i) {
                self.grid.compactRowOver(i)
                self.deleteFullRow()
                break;
            }
        }
    }

}
