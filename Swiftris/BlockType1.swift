/*
 *  BlockType1.swift
 *  Swiftris
 *
 *  Created by cgkim on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockType1: Block {

    init() {
        super.init()
        
        self.grid[0, 1] = 1
        self.grid[0, 2] = 1
        self.grid[1, 1] = 1
        self.grid[1, 2] = 1
    }

}
