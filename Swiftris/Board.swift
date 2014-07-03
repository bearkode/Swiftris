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
    
    var grid: Grid
    var dirty = true

    init(size boardSize: GridSize) {
        self.grid = Grid(width: boardSize.width, height: boardSize.height)
    }
    
    func valueAtPosition(position: Point) -> Int {
        return grid[position]
    }
    
    func isOverlappedAtPosition(position: Point, block: Block) -> Bool {
        return grid.isOverlappedAtPosition(position, grid: block.currentGrid)
    }
    
    func isPossiblePosition(position: Point, block: Block) -> Bool {
        return !grid.isOverlappedAtPosition(position, grid: block.currentGrid)
    }
    
    func isPossiblePosition(position: Point, grid: Grid) -> Bool {
        return !self.grid.isOverlappedAtPosition(position, grid: grid)
    }
    
    func immobilzeBlock(block: Block) {
        grid.copyGrid(block.currentGrid, position: block.position)
        dirty = true
    }
    
    func deleteFullRow() {
        for i in (grid.gridSize.height - 1...0).by(-1) {
            if grid.isFullRow(i) {  //  TODO : grid.findFullRow() grid.compactRowOver(), deleteFullRow()
                grid.compactRowOver(i)
                deleteFullRow()
                break;
            }
        }
    }

}