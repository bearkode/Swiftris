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
    
    override func generateTemplate() {
        super.generateTemplate()
        
        let c = 7
        
        appendTemplate(Grid(width: 4, height: 4, array: [c, 0, 0, 0,
                                                         c, c, 0, 0,
                                                         0, c, 0, 0]))
        
        appendTemplate(Grid(width: 4, height: 4, array: [0, c, c, 0,
                                                         c, c, 0, 0]))
    }

}
