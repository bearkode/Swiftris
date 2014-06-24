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
    
    var board = Board(size: GridSize(width: 20, height: 30))
    var block = BlockE()
    
    var boardGridSize: GridSize {
        get {
            return board.gridSize
        }
    
        set {
    
        }
    }
    
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
    
    func colorIndexAtPosition(position: Point) -> Int {
        return board.valueAtPosition(position)
    }
}