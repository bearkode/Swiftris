/*
 *  BlockF.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockF: Block {
    
    init() {
        super.init()
    }
 
    override func generateTemplate() {
        super.generateTemplate()
        
        var c = 6
        var grid: Grid
        
        grid = Grid(width: 4, height: 4)
        grid.appendWithRowArray([0, c, 0, 0], y: 0)
        grid.appendWithRowArray([c, c, 0, 0], y: 1)
        grid.appendWithRowArray([c, 0, 0, 0], y: 2)
        grids += grid
        
        grid = Grid(width: 4, height: 4)
        grid.appendWithRowArray([c, c, 0, 0], y: 0)
        grid.appendWithRowArray([0, c, c, 0], y: 1)
        grid.appendWithRowArray([0, 0, 0, 0], y: 2)
        grids += grid
    }

}
