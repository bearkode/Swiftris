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
        
        self.grid[1, 0] = 4
        self.grid[2, 0] = 4
        self.grid[1, 1] = 4
        self.grid[1, 2] = 4
    }

}
