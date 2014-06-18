/*
 *  BlockType4.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockType4: Block {

    init() {
        super.init()
    }

    override func generateTemplate() {
        super.generateTemplate()
        
        var c = 4
        var newGrid: Grid

        newGrid = Grid(width: 4, height: 4)
        newGrid.appendWithRowArray([0, c, c, 0], y: 0)
        newGrid.appendWithRowArray([0, c, 0, 0], y: 1)
        newGrid.appendWithRowArray([0, c, 0, 0], y: 2)
        grids += newGrid
        
        newGrid = Grid(width: 4, height: 4)
        newGrid.appendWithRowArray([c, c, c, 0], y: 0)
        newGrid.appendWithRowArray([0, 0, c, 0], y: 1)
        newGrid.appendWithRowArray([0, 0, 0, 0], y: 2)
        grids += newGrid
        
        newGrid = Grid(width: 4, height: 4)
        newGrid.appendWithRowArray([0, 0, c, 0], y: 0)
        newGrid.appendWithRowArray([0, 0, c, 0], y: 1)
        newGrid.appendWithRowArray([0, c, c, 0], y: 2)
        grids += newGrid
        
        newGrid = Grid(width: 4, height: 4)
        newGrid.appendWithRowArray([c, 0, 0, 0], y: 0)
        newGrid.appendWithRowArray([c, c, c, 0], y: 1)
        newGrid.appendWithRowArray([0, 0, 0, 0], y: 2)
        grids += newGrid
    }
    
}
