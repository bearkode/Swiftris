/*
 *  GameLogicController.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 17..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


protocol LogicControllerDelegate {

    func logicControllerDidUpdate(logicController: GameLogicController)
    
}


/*  NSObject를 상속받지 않으면 NSTimer의 target으로 설정할 수 없음  */
class GameLogicController: NSObject {
    
    var delegate: LogicControllerDelegate?
    
    init () {
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
            if board.isPossiblePosition(block.leftPosition, block: block) {
                block.moveLeft()
            }
        }
    }

    func rightArrowDown() {
        if let block = self.block {
            if board.isPossiblePosition(block.rightPosition, block: block) {
                block.moveRight()
            }
        }
    }
    
    func bottomArrowDown() {

    }
    
    func colorIndexAtPosition(position: Point) -> Int {
        if let block = self.block {
            if block.containsPosition(position) {
                var value = block.valueAtPosition(position)
                if value != 0 {
                    return value
                }
            }
        }
        
        return board.valueAtPosition(position)
    }
    
    func timerFired() {
        generateBlockIfNeeded()
        dropBlock()
        sendDidUpdateIfNeeded()
    }
    
    func generateBlockIfNeeded() {
        if self.block != nil {
            return
        }
        
        self.block = Block.randomBlock()
        
        if let block = self.block {
            block.position = Point(x: 3, y: 0)
            
            if board.isOverlappedAtPosition(block.position, block: block) {
                println("Game Over")
            }
        }
    }
    
    func dropBlock() {
        if let block = self.block {
            if block.isTimeToDrop() {
                if checkBlockDownCollision(block) {
                    immobilizeBlock(block)
                    board.deleteFullRow()
                } else {
                    block.moveDown()
                }
            }
        }
    }
    
    func checkBlockDownCollision(block: Block!) -> Bool {
        return board.isOverlappedAtPosition(block.lowPosition, block: block)
    }
    
    func immobilizeBlock(block: Block!) {
        board.immobilzeBlock(block)
        self.block = nil
    }
    
    func sendDidUpdateIfNeeded() {
        if isDirtyStatus() {
            delegate?.logicControllerDidUpdate(self)
        }
    }
    
    func isDirtyStatus() -> Bool {
        if block?.dirty == true {
            block!.dirty = false
            return true
        }

        if board.dirty == true {
            board.dirty = false
            return true
        }
        
        return false
    }
    
    /*
     *  Privates
     */
    var board = Board(size: GridSize(width: 10, height: 20))
    var timer: NSTimer?
    var block: Block?
    
    var boardGridSize: GridSize {
        get {
            return board.gridSize
        }
    }

}