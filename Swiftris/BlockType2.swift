/*
 *  BlockType2.swift
 *  Swiftris
 *
 *  Created by cgkim on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockType2: Block {

    init() {
        super.init()
        
        self.grid[1, 0] = 2
        self.grid[1, 1] = 2
        self.grid[1, 2] = 2
        self.grid[1, 3] = 2
    }

}