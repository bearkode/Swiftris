/*
 *  BlockType2.swift
 *  Swiftris
 *
 *  Created by cgkim on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockType2: Block {

    init() {
        super.init()
    }
    
    override func generateTemplate() {
        super.generateTemplate()
        
        var colorIndex = 2
        var newGrid: Grid

        newGrid = Grid(width: 4, height: 4)
        newGrid[1, 0] = colorIndex
        newGrid[1, 1] = colorIndex
        newGrid[1, 2] = colorIndex
        newGrid[1, 3] = colorIndex
        grids += newGrid
        
        newGrid = Grid(width: 4, height: 4)
        newGrid[0, 1] = colorIndex
        newGrid[1, 1] = colorIndex
        newGrid[2, 1] = colorIndex
        newGrid[3, 1] = colorIndex
        grids += newGrid

    }

}