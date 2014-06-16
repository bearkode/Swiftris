/*
 *  BlockType6.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockType6: Block {
    
    init() {
        super.init()
        
        self.grid[1, 0] = 6
        self.grid[0, 1] = 6
        self.grid[1, 1] = 6
        self.grid[0, 2] = 6
    }
    
}
