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
        return grid.isOverlappedGrid(block.currentGrid, position: position)
    }
    
    func isPossiblePosition(position: Point, block: Block) -> Bool {
        return !grid.isOverlappedGrid(block.currentGrid, position: position)
    }
    
    func isPossiblePosition(position: Point, grid: Grid) -> Bool {
        return !self.grid.isOverlappedGrid(grid, position: position)
    }
    
    func immobilzeBlock(block: Block) {
        grid.copyGrid(block.currentGrid, position: block.position)
        dirty = true
    }
    
    func deleteFullRow() {
        for var i = (grid.gridSize.height - 1); i >= 0; i-- {
//        for i in stride(from: grid.gridSize.height - 1, to: 0, by: -1.0) {
            if grid.isFullRow(i) {  //  TODO : grid.findFullRow() grid.compactRowOver(), deleteFullRow()
                grid.compactRowOver(i)
                deleteFullRow()
                break;
            }
        }
    }

}