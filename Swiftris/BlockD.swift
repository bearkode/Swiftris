/*
 *  BlockD.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockD: Block {
    
    override class func gridsForBlock() -> [Grid] {
        return BlockTemplate.blockD
    }

}
