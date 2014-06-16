/*
 *  BlockType7.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockType7: Block {
    
    init() {
        super.init()
        
        self.grid[0, 0] = 7
        self.grid[0, 1] = 7
        self.grid[1, 1] = 7
        self.grid[1, 2] = 7
    }
    
}
