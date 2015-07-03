/*
 *  BlockG.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockG: Block {
    
    required init() {
        super.init()
        
        let c = 7
        self.grids = [Grid(width: 4, height: 4, array: [c, 0, 0, 0,
                                                        c, c, 0, 0,
                                                        0, c, 0, 0]),
                      Grid(width: 4, height: 4, array: [0, c, c, 0,
                                                        c, c, 0, 0])]
    }

}
