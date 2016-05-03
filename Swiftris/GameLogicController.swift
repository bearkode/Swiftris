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
    let board = Board(size: GridSize(width: 10, height: 20))
    var block: Block?
    var boardSize: GridSize {
        return self.board.gridSize
    }

    //  MARK: - init
    override init () {
        super.init()

        //  TODO: 다른 곳으로 이동
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0 / 30.0, target: self, selector: #selector(timeTick), userInfo: nil, repeats: true)
    }

    //  MARK: - public
    func colorIndexAtPosition(position: Point) -> Int {
        if let value = self.block?.valueAtPosition(position) where value != 0 {
            return value
        }
        
        return board.valueAtPosition(position)
    }

    func handleKeyCode(keyCode: BKKeyCode) {
        self.keyCodeHandlers[keyCode]?()
    }
    
    func timeTick() {
        if let block = self.block {
            if block.timeToDrop {
                self.dropBlock()
            }
        } else {
            self.generateBlock()
            self.checkGameOver()
        }
        
        self.sendDidUpdate()
    }

    //  MARK: - private
    private var timer: NSTimer?

    private func generateBlock() {
        assert(self.block == nil)
        self.block = Block.randomBlock(Point(x: 3, y: 0))
    }

    private func dropBlock() {
        guard let _ = self.block else {
            return
        }

        if self.checkBlockDownCollision() {
            self.immobilizeBlock()
            self.deleteFullRow()
        } else {
            self.moveDownBlock()
        }
    }
    
    private func immobilizeBlock() {
        guard let block = self.block else {
            return
        }
        
        self.board.immobilzeBlock(block)
        self.block = nil
    }
    
    private func deleteFullRow() {
        self.board.deleteFullRow()
    }
    
    private func sendDidUpdate() {
        if self.dirty {
            self.delegate?.logicControllerDidUpdate(self)
            self.resetDirty()
        }
    }

    private var dirty : Bool {
        if self.board.dirty {
            return true
        } else {
            return self.block?.dirty ?? false
        }
    }
    
    private func resetDirty() {
        self.board.dirty = false
        self.block?.dirty = false
    }
    
    private func checkGameOver() {
        guard let block = self.block else {
            return
        }

        if self.board.isOverlappedAtPosition(block.position, block: block) {
            print("Game Over")
        }
    }

    private func checkBlockDownCollision() -> Bool {
        guard let block = self.block else {
            return false
        }

        return self.board.isOverlappedAtPosition(block.position.underPoint, block: block)
    }
    
    private lazy var keyCodeHandlers: [BKKeyCode: () -> Void] = {
        return [BKKeyCode.Up : self.upArrowDown,
                BKKeyCode.Right : self.rightArrowDown,
                BKKeyCode.Left : self.leftArrowDown,
                BKKeyCode.Down : self.downArrowDown]
    } ()
    
}