/*
 *  BlockType3.swift
 *  Swiftris
 *
 *  Created by cgkim on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockType3: Block {
    
    var grids: Grid[] = Array()
    
    init() {
        super.init()

        self.grid = grids[3]
    }
    
    override func generateTemplate() {
        var grid1 = Grid(width: 4, height: 4)
        grid1[1, 0] = 3
        grid1[2, 0] = 3
        grid1[2, 1] = 3
        grid1[2, 2] = 3
        grids.append(grid1)
        
        var grid2 = Grid(width: 4, height: 4)
        grid2[2, 0] = 3
        grid2[0, 1] = 3
        grid2[1, 1] = 3
        grid2[2, 1] = 3
        grids.append(grid2)
        
        var grid3 = Grid(width: 4, height: 4)
        grid3[1, 0] = 3
        grid3[1, 1] = 3
        grid3[1, 2] = 3
        grid3[2, 2] = 3
        grids.append(grid3)
        
        var grid4 = Grid(width: 4, height: 4)
        grid4[0, 0] = 3
        grid4[1, 0] = 3
        grid4[2, 0] = 3
        grid4[0, 1] = 3
        grids.append(grid4)
    }
}