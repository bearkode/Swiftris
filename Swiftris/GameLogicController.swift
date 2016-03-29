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
    var boardSize: GridSize {
        return self.board.gridSize
    }

    override init () {
        super.init()

        //  TODO: 다른 곳으로 이동
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0 / 30.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    func colorIndexAtPosition(position: Point) -> Int {
        if let value = self.block?.valueAtPosition(position) where value != 0 {
            return value
        }
        
        return board.valueAtPosition(position)
    }
    
    //  MARK: - private
    let board = Board(size: GridSize(width: 10, height: 20))
    var block: Block?
    var timer: NSTimer?

    func handleKeyCode(keyCode: BKKeyCode) {
        self.keyCodeHandlers[keyCode]?()
    }
    
    func timerFired() {
        guard let block = self.block else {
            self.generateBlockIfNeeded()
            self.checkGameOver()
            return
        }
        
        if block.timeToDrop {
            self.dropBlock()
        }
        
        self.sendDidUpdateIfNeeded()
    }
    
    func generateBlockIfNeeded() {
        if self.block == nil {
            self.block = Block.randomBlock(Point(x: 3, y: 0))
        }
    }

    private func dropBlock() {
        if self.checkBlockDownCollision() {
            self.immobilize()
            self.deleteFullRow()
        } else {
            self.moveDownBlock()
        }
    }
    
    private func immobilize() {
        guard let block = self.block else {
            return
        }
        
        self.board.immobilzeBlock(block)
        self.block = nil
    }
    
    func deleteFullRow() {
        self.board.deleteFullRow()
    }
    
    func sendDidUpdateIfNeeded() {
        if self.dirty {
            self.delegate?.logicControllerDidUpdate(self)
            self.resetDirty()
        }
    }

    var dirty : Bool {
        if self.board.dirty {
            return true
        } else {
            return self.block?.dirty ?? false
        }
    }
    
    func resetDirty() {
        self.board.dirty = false
        self.block?.dirty = false
    }
    
    func checkGameOver() {
        guard let block = self.block else {
            return
        }

        if self.board.isOverlappedAtPosition(block.position, block: block) {
            print("Game Over")
        }
    }

    func checkBlockDownCollision() -> Bool {
        guard let block = self.block else {
            return false
        }

        return self.board.isOverlappedAtPosition(block.position.underPoint, block: block)
    }
    
    //  MARK: - private
    private lazy var keyCodeHandlers: [BKKeyCode: () -> Void] = {
        return [BKKeyCode.Up : self.upArrowDown,
                BKKeyCode.Right : self.rightArrowDown,
                BKKeyCode.Left : self.leftArrowDown,
                BKKeyCode.Down : self.downArrowDown]
    } ()
    
}