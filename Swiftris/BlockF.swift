/*
 *  BlockF.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockF: Block {
    
    override class func gridsForBlock() -> [Grid] {
        let c = 6
        return [Grid(width: 4, height: 4, array: [0, c, 0, 0,
                                                  c, c, 0, 0,
                                                  c, 0, 0, 0]),
                Grid(width: 4, height: 4, array: [c, c, 0, 0,
                                                  0, c, c, 0])]
    }

}
