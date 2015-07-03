/*
 *  BlockA.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockA: Block {

    required init() {
        super.init()

        let c = 1
        self.grids = [Grid(width: 4, height: 4, array: [0, c, c, 0,
                                                        0, c, c, 0])]
    }

}
