/*
 *  BlockType5.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockType5: Block {
    
    init() {
        super.init()
        
        self.grid[1, 0] = 5
        self.grid[0, 1] = 5
        self.grid[1, 1] = 5
        self.grid[2, 1] = 5
    }
    
}
