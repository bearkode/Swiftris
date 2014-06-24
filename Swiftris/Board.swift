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
    var gridSize: GridSize

    init(size boardSize: GridSize) {
        self.grid = Grid(width: boardSize.width, height: boardSize.height)
        self.gridSize = boardSize
        self.fillWithRandomValue()
    }
    
    func fillWithRandomValue() {
        gridSize.enumerateGrids { (position: Point) in
            self.grid[position.x, position.y] = Int(arc4random() % 7)
        }
    }
    
    func valueAtPosition(position: Point) -> Int {
        return grid[position]
    }
    
}