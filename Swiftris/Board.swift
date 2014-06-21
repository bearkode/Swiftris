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

    init(size boardSize: CGSize) {
        self.grid = Grid(width: Int(boardSize.width), height: Int(boardSize.height))
        self.fillWithRandomValue()
    }
    
    func fillWithRandomValue() {
        for var y = 0; y < grid.height; y++ {
            for var x = 0; x < grid.width; x++ {
                let value = Int(arc4random() % 7)
                grid[x, y] = value
            }
        }
        
        grid.enumerateGrids { (x: Int, y: Int, value: Int) in
            println("value = \(value)")
        }
    }
    
}