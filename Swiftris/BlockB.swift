/*
 *  BlockB.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 16..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockB: Block {

    override func generateTemplate() {
        super.generateTemplate()
        
        let c = 2

        appendTemplate(Grid(width: 4, height: 4, array: [0, c, 0, 0,
                                                         0, c, 0, 0,
                                                         0, c, 0, 0,
                                                         0, c, 0, 0]))
        
        appendTemplate(Grid(width: 4, height: 4, array: [0, 0, 0, 0,
                                                         c, c, c, c]))
    }

}