/*
 *  BlockType6.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockType6: Block {
    
    init() {
        super.init()
        
        self.grid[1, 0] = 6
        self.grid[0, 1] = 6
        self.grid[1, 1] = 6
        self.grid[0, 2] = 6
    }
 
    override func generateTemplate() {
        super.generateTemplate()
        
        var colorIndex = 6
        var newGrid: Grid
        
        newGrid = Grid(width: 4, height: 4)
//        newGrid[1, 0] = colorIndex
//        newGrid[0, 1] = colorIndex
//        newGrid[1, 1] = colorIndex
//        newGrid[2, 1] = colorIndex
        grids += newGrid
        
        newGrid = Grid(width: 4, height: 4)
//        newGrid[1, 0] = colorIndex
//        newGrid[1, 1] = colorIndex
//        newGrid[1, 2] = colorIndex
//        newGrid[2, 1] = colorIndex
        grids += newGrid
        
        newGrid = Grid(width: 4, height: 4)
//        newGrid[0, 0] = colorIndex
//        newGrid[1, 0] = colorIndex
//        newGrid[2, 0] = colorIndex
//        newGrid[1, 1] = colorIndex
        grids += newGrid
        
        newGrid = Grid(width: 4, height: 4)
//        newGrid[1, 0] = colorIndex
//        newGrid[1, 1] = colorIndex
//        newGrid[1, 2] = colorIndex
//        newGrid[0, 1] = colorIndex
        grids += newGrid
    }

}
