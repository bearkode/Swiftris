/*
 *  GameLogicController.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 17..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


public protocol LogicControllerDelegate: class {
    
    func logicControllerDidStartGame(_ logicController: GameLogicController)
    func logicControllerDidPause(_ logicController: GameLogicController)
    func logicControllerDidResume(_ logicController: GameLogicController)
    func logicControllerDidGameOver(_ logicController: GameLogicController)
    func logicControllerDidUpdate(_ logicController: GameLogicController)

}


public class GameLogicController: NSObject {
    
    public weak var delegate: LogicControllerDelegate?
    public var boardSize: GridSize {
        return self.board.gridSize
    }

    //  MARK: - init
    public override init () {
        super.init()
    }

    //  MARK: - public
    public func colorIndex(at position: Point) -> Int {
        if let value = self.block?.value(at: position), value != 0 {
            return value
        }
        
        return board.value(at: position)
    }

    public func handleKeyCode(_ keyCode: KeyCode) {
        self.keyCodeHandlers[keyCode]?()
    }
    
    public func timeTick() {
        if self.state != .playing {
            return
        }
        
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

    //  MARK: - internal
    let board = Board(size: GridSize(width: 10, height: 20))
    var block: Block?
    var state: State = .ready {
        didSet {
            switch self.state {
            case .ready:
                ()
            case .playing:
                if oldValue == .ready || oldValue == .gameOver {
                    self.board.reset()
                    self.block = nil
                    self.delegate?.logicControllerDidStartGame(self)
                } else {
                    self.delegate?.logicControllerDidResume(self)
                }
            case .pause:
                self.delegate?.logicControllerDidPause(self)
            case .gameOver:
                self.delegate?.logicControllerDidGameOver(self)
            }
        }
    }

    //  MARK: - private
    private lazy var keyCodeHandlers: [KeyCode: () -> Void] = {
        return [.up: self.upArrowDown,
                .right: self.rightArrowDown,
                .left: self.leftArrowDown,
                .down: self.downArrowDown]
    } ()

}


fileprivate extension GameLogicController {

    func generateBlock() {
        assert(self.block == nil)
        self.block = BlockGenerator.sharedGenerator.block(withPosition: Point(x: 3, y: 0))
    }
    
    func dropBlock() {
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
    
    func immobilize(block: Block) {
        self.board.immobilze(block: block)
        self.block = nil
    }
    
    func sendDidUpdate() {
        if self.isDirty {
            self.delegate?.logicControllerDidUpdate(self)
            self.resetDirty()
        }
    }
    
    var isDirty : Bool {
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
        
        if self.board.isOverlapped(with: block, at: block.position) {
            self.state = .gameOver
        }
    }
    
    func checkBlockDownCollision(_ block: Block) -> Bool {
        return self.board.isOverlapped(with: block, at: block.position.underPoint)
    }
    
}
