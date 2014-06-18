/*
 *  BlockType1.swift
 *  Swiftris
 *
 *  Created by cgkim on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockType1: Block {

    init() {
        super.init()
    }
    
    override func generateTemplate() {
        super.generateTemplate()
        
        var c = 1
        var newGrid: Grid

        newGrid = Grid(width: 4, height: 4)
        newGrid.appendWithRowArray([0, c, c, 0], y: 0)
        newGrid.appendWithRowArray([0, c, c, 0], y: 1)
        grids += newGrid
    }

}
