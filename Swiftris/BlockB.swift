/*
 *  BlockB.swift
 *  Swiftris
 *
 *  Created by cgkim on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockB: Block {

    init() {
        super.init()
    }
    
    override func generateTemplate() {
        super.generateTemplate()
        
        var c = 2
        var grid: Grid

        grid = Grid(width: 4, height: 4)
        grid.appendWithRowArray([0, c, 0, 0], y: 0)
        grid.appendWithRowArray([0, c, 0, 0], y: 1)
        grid.appendWithRowArray([0, c, 0, 0], y: 2)
        grid.appendWithRowArray([0, c, 0, 0], y: 3)
        grids += grid
        
        grid = Grid(width: 4, height: 4)
        grid.appendWithRowArray([0, 0, 0, 0], y: 0)
        grid.appendWithRowArray([c, c, c, c], y: 1)
        grid.appendWithRowArray([0, 0, 0, 0], y: 2)
        grid.appendWithRowArray([0, 0, 0, 0], y: 3)
        grids += grid

    }

}