/*
 *  BlockA.swift
 *  Swiftris
 *
 *  Created by cgkim on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockA: Block {

    init() {
        super.init()
    }
    
    override func generateTemplate() {
        super.generateTemplate()
        
        var c = 1
        var grid: Grid

        grid = Grid(width: 4, height: 4)
        grid.appendWithRowArray([0, c, c, 0], y: 0)
        grid.appendWithRowArray([0, c, c, 0], y: 1)
        grids += grid
    }

}
