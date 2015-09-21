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
            return self.board.gridSize
        }
    }

    override init () {
        super.init()

        //  다른 곳으로 이동
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0 / 30.0, target: self, selector: Selector("timerFired"), userInfo: nil, repeats: true)
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
            self.generateBlockIfNeeded()
            self.checkGameOver()
        }
        self.sendDidUpdateIfNeeded()
    }
    
    func generateBlockIfNeeded() {
        if self.block == nil {
            self.block = Block.randomBlock(Point(x: 3, y: 0))
        }
    }
    
    func dropBlock(block: Block) {
        if checkBlockDownCollision(block) {
            immobilize(block)
            deleteFullRow()
        } else {
            moveDownBlock(block)
        }
    }
    
    func immobilize(block: Block) {
        board.immobilzeBlock(block)
        self.block = nil
    }
    
    func deleteFullRow() {
        self.board.deleteFullRow()
    }
    
    func sendDidUpdateIfNeeded() {
        if self.isDirty() {
            self.delegate?.logicControllerDidUpdate(self)
            self.resetDirty()
        }
    }

    func isDirty() -> Bool {
        if self.board.dirty {
            return true;
        } else if let block = self.block {
            return block.movement.dirty
        } else {
            return false;
        }
    }
    
    func resetDirty() {
        self.block?.movement.dirty = false
        self.board.dirty = false
    }
    
    func checkGameOver() {
        if let block = self.block {
            if self.board.isOverlappedAtPosition(block.position, block: block) {
                print("Game Over")
            }
        }
    }

    func checkBlockDownCollision(block: Block!) -> Bool {
        return self.board.isOverlappedAtPosition(block.position.underPoint, block: block)
    }
    
}