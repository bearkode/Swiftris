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


public class GameLogicController {
    
    public weak var delegate: LogicControllerDelegate?
    public var boardSize: GridSize {
        return self.board.gridSize
    }

    //  MARK: - init
    public init () {

    }

    //  MARK: - public
    public func colorIndex(at position: Point) -> Int {
        if let value = self.block?.value(at: position), value != 0 {
            return value
        }
        
        return board.value(at: position)
    }

    public func handleKeyCode(_ keyCode: KeyCode) {
        guard self.state is PlayingState else {
            return
        }
        self.keyCodeHandlers[keyCode]?()
    }
    
    public func timeTick() {
        guard self.state is PlayingState else {
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
    var state: GameState = ReadyState() {
        didSet {
            if self.state.isStarted {
                self.didStart()
            } else if self.state.isResumed {
                self.didResume()
            } else if self.state.isPaused {
                self.didPause()
            } else if self.state.isGameOver {
                self.didGameOver()
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
    
    func didStart() {
        self.board.reset()
        self.block = nil
        self.delegate?.logicControllerDidStartGame(self)
    }
    
    func didResume() {
        self.delegate?.logicControllerDidResume(self)
    }

    func didPause() {
        self.delegate?.logicControllerDidPause(self)
    }
    
    func didGameOver() {
        self.delegate?.logicControllerDidGameOver(self)
        self.state = self.state.nextState
    }

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
        self.dirtyCheckables.checkDirty {
            self.delegate?.logicControllerDidUpdate(self)
        }
    }
    
    var dirtyCheckables: [DirtyCheckable] {
        return Array<DirtyCheckable?>(arrayLiteral: self.board, self.block).compactMap {
            $0
        }
    }
    
    func checkGameOver() {
        guard let block = self.block else {
            return
        }
        
        if self.board.isOverlapped(with: block, at: block.position) {
            self.state = self.state.gameoverState
        }
    }
    
    func checkBlockDownCollision(_ block: Block) -> Bool {
        return self.board.isOverlapped(with: block, at: block.position.underPoint)
    }
    
}
