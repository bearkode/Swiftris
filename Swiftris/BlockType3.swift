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
    
    init() {
        super.init()
        
        self.grid[1, 0] = 3
        self.grid[2, 0] = 3
        self.grid[2, 1] = 3
        self.grid[2, 2] = 3
    }
    
}