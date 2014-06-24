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
    var board = Board(size: GridSize(width: 10, height: 20))
    var timer: NSTimer?
    var block: Block?
    let dropCountForLevel = 5
    var dropCount: Int = 0
    
    var boardGridSize: GridSize {
        get {
            return board.gridSize
        }
    }
    
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
        if let block = self.block {
        
        }
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
            block.position = Point(x: 5, y: board.gridSize.height - 1)
            dropCount = dropCountForLevel
            
            if board.isOverlappedAtPosition(block.position, block: block) {
                println("Game Over")
            }
        }
    }
    
    func dropBlock() {
        if let block = self.block {
            if dropCount-- < 0 {
                println("block = \(block)")
                if checkBlockUnderCollision() {
                    immobilizeBlock()
                    self.block = nil
                } else {
                    block.moveDown()
                    dropCount = dropCountForLevel
                }
            }
        }
    }
    
    func checkBlockUnderCollision() -> Bool {
        if let block = self.block {
            if board.isOverlappedAtPosition(block.lowPosition, block: block) == true {
                return true
            }
        }
        
        return false
    }
    
    func immobilizeBlock() {
        if let block = self.block {
            board.immobilzeBlock(block)
        }
    }
    
    func sendDidUpdateIfNeeded() {
        if isDirtyStatus() {
            if let delegate = self.delegate? {
                delegate.logicControllerDidUpdate(self)
            }
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

}