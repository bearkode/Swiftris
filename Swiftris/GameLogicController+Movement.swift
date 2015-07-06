/*
 *  GameLogicController+Movement.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 6..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import Foundation


extension GameLogicController {

    func upArrowDown() {
        guard let block = self.block else {
            return
        }
        
        if board.isPossiblePosition(block.position, grid: block.nextGrid) {
            block.turn()
        }
    }
    
    func leftArrowDown() {
        guard let block = self.block else {
            return
        }
        
        if board.isPossiblePosition(block.position.leftPoint, block: block) {
            block.moveLeft()
        }
    }
    
    func rightArrowDown() {
        guard let block = self.block else {
            return
        }
        
        if board.isPossiblePosition(block.position.rightPoint, block: block) {
            block.moveRight()
        }
    }
    
    func bottomArrowDown() {
        
    }
    
    func moveDownBlock(block: Block!) {
        block.moveDown()
    }

}