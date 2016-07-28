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
        
        if self.board.isPossible(at: block.position, withGrid: block.nextShape) {
            block.turn()
        }
    }
    
    func leftArrowDown() {
        guard let block = self.block else {
            return
        }
        
        if self.board.isPossible(at: block.position.leftPoint, withBlock: block) {
            block.moveLeft()
        }
    }
    
    func rightArrowDown() {
        guard let block = self.block else {
            return
        }
        
        if self.board.isPossible(at: block.position.rightPoint, withBlock: block) {
            block.moveRight()
        }
    }
    
    func downArrowDown() {
        
    }
    
    func moveDownBlock() {
        self.block?.moveDown()
    }

}
