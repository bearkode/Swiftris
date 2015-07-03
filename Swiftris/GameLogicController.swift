/*
 *  GameLogicController.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 17..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


protocol LogicControllerDelegate: class {
    func logicControllerDidUpdate(logicController: GameLogicController)
}


class GameLogicController: NSObject {
    
    weak var delegate: LogicControllerDelegate?
    var boardGridSize: GridSize {
        get {
            return self.board.grid.size  // TODO : avoid message chain
        }
    }

    override init () {
        super.init()

        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0 / 30.0, target: self, selector: Selector("timerFired"), userInfo: nil, repeats: true)
    }
    
    func upArrowDown() {
        if let block = self.block {
            if board.isPossiblePosition(block.position, grid: block.nextGrid) {
                block.turn()
            }
        }
    }

    func leftArrowDown() {
        if let block = self.block {
            if board.isPossiblePosition(block.position.leftPoint, block: block) {   // TODO : avoid message chain
                block.moveLeft()
            }
        }
    }

    func rightArrowDown() {
        if let block = self.block {
            if board.isPossiblePosition(block.position.rightPoint, block: block) {  // TODO : avoid message chain
                block.moveRight()
            }
        }
    }
    
    func bottomArrowDown() {

    }
    
    func colorIndexAtPosition(position: Point) -> Int {
        if let value = block?.valueAtPosition(position) where value != 0 {
            return value
        }
        
        return board.valueAtPosition(position)
    }
    
    /*
     *  Privates
     */
    var board = Board(size: GridSize(width: 10, height: 20))
    var block: Block?
    var timer: NSTimer?

    func timerFired() {
        if let block = self.block where block.isTimeToDrop() {
            self.dropBlock(block)
        } else {
            generateBlockIfNeeded()
            checkGameOver()
        }
        sendDidUpdateIfNeeded()
    }
    
    func generateBlockIfNeeded() {
        if block == nil {
            block = Block.randomBlock()
            block?.position = Point(x: 3, y: 0)
        }
    }
    
    func dropBlock(block: Block!) {
        if checkBlockDownCollision(block) {
            immobilizeBlock(block)
            deleteFullRow()
        } else {
            moveDownBlock(block)
        }
    }
    
    func immobilizeBlock(block: Block!) {
        board.immobilzeBlock(block)
        self.block = nil
    }
    
    func deleteFullRow() {
        board.deleteFullRow()
    }
    
    func moveDownBlock(block: Block!) {
        block.moveDown()
    }
    
    func sendDidUpdateIfNeeded() {
        if isDirty() {
            delegate?.logicControllerDidUpdate(self)
            resetDirty()
        }
    }

    func isDirty() -> Bool {
        if board.dirty {
            return true;
        } else if let block = self.block {
            return block.dirty
        } else {
            return false;
        }
    }
    
    func resetDirty() {
        if let block = self.block {
            block.dirty = false;
        }
        board.dirty = false
    }
    
    func checkGameOver() {
        if let block = self.block {
            if board.isOverlappedAtPosition(block.position, block: block) {
                print("Game Over")
            }
        }
    }

    func checkBlockDownCollision(block: Block!) -> Bool {
        return board.isOverlappedAtPosition(block.position.underPoint, block: block) //  TODO : avoid message chain
    }
    
}