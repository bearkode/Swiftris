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
    
    func logicControllerDidUpdate(_ logicController: GameLogicController)

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
        self.timer = Timer.scheduledTimer(timeInterval: 1.0 / 30.0, target: self, selector: #selector(timeTick), userInfo: nil, repeats: true)
    }

    //  MARK: - public
    func colorIndex(at position: Point) -> Int {
        if let value = self.block?.value(at: position), value != 0 {
            return value
        }
        
        return board.value(at: position)
    }

    func handleKeyCode(_ keyCode: BKKeyCode) {
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
    private var timer: Timer?
    private lazy var keyCodeHandlers: [BKKeyCode: () -> Void] = {
        return [BKKeyCode.up: self.upArrowDown,
                BKKeyCode.right: self.rightArrowDown,
                BKKeyCode.left: self.leftArrowDown,
                BKKeyCode.down: self.downArrowDown]
    } ()

}


private extension GameLogicController {

    private func generateBlock() {
        assert(self.block == nil)
        self.block = Block.randomBlock(withPosition: Point(x: 3, y: 0))
    }
    
    private func dropBlock() {
        guard let block = self.block else {
            return
        }
        
        if self.checkBlockDownCollision(block) {
            self.immobilize(block: block)
            self.board.deleteFullRow()
        } else {
            block.moveDown()
        }
    }
    
    private func immobilize(block: Block) {
        self.board.immobilze(block: block)
        self.block = nil
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
        
        if self.board.isOverlapped(with: block, at: block.position) {
            print("Game Over")
        }
    }
    
    private func checkBlockDownCollision(_ block: Block) -> Bool {
        return self.board.isOverlapped(with: block, at: block.position.underPoint)
    }
    
}
