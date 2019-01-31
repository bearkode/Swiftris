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

    internal func upArrowDown() {
        self.block.map {
            if self.board.isPossible(at: $0.position, withGrid: $0.nextShape) {
                $0.turn()
            }
        }
    }

    internal func leftArrowDown() {
        self.block.map {
            if self.board.isPossible(at: $0.position.leftPoint, withBlock: $0) {
                $0.moveLeft()
            }
        }
    }

    internal func rightArrowDown() {
        self.block.map {
            if self.board.isPossible(at: $0.position.rightPoint, withBlock: $0) {
                $0.moveRight()
            }
        }
    }

    internal func downArrowDown() {

    }

}
