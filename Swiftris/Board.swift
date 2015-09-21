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
    var gridSize: GridSize {
        get {
            return self.grid.size
        }
    }

    init(size boardSize: GridSize) {
        self.grid = Grid(width: boardSize.width, height: boardSize.height)
    }
    
    /**
    
    */
    
    func valueAtPosition(position: Point) -> Int {
        return grid[position]
    }
    
    func isOverlappedAtPosition(position: Point, block: Block) -> Bool {
        return grid.isOverlappedGrid(block.currentGrid, position: position)
    }
    
    func isPossiblePosition(position: Point, block: Block) -> Bool {
        return self.isPossiblePosition(position, grid: block.currentGrid)
    }
    
    func isPossiblePosition(position: Point, grid: Grid) -> Bool {
        return !self.grid.isOverlappedGrid(grid, position: position)
    }
    
    func immobilzeBlock(block: Block) {
        grid.copyGrid(block.currentGrid, position: block.position)
        dirty = true
    }
    
    func deleteFullRow() {
//        for i in stride(from: self.grid.size.height - 1, through: 0, by: -1) {
        for var i = self.grid.size.height - 1; i >= 0; i-- {
            if grid.isFullRow(i) {
                grid.compactRowOver(i)
                self.deleteFullRow()
                break;
            }
        }
    }

}