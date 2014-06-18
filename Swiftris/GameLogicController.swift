/*
 *  GameLogicController.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 17..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class GameLogicController {
    
    var block = BlockType3()
    
    init () {
    
    }
    
    func upArrowDown() {
        block.turn()
        block.debugPrint()
    }

    func leftArrowDown() {
        block.moveLeft()
    }

    func rightArrowDown() {
        block.moveRight()
    }
    
    func downArrowDown() {
        // TODO : do drop logic
    }
    
}