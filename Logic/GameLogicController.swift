/*
 *  GameLogicController.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 17..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


public protocol LogicControllerDelegate: AnyObject {

    func logicControllerDidStartGame(_ logicController: GameLogicController)
    func logicControllerDidPause(_ logicController: GameLogicController)
    func logicControllerDidResume(_ logicController: GameLogicController)
    func logicControllerDidGameOver(_ logicController: GameLogicController)
    func logicControllerDidUpdate(_ logicController: GameLogicController)

}


public class GameLogicController {

    // MARK: - init

    public init () {

    }

    // MARK: - public

    public weak var delegate: LogicControllerDelegate?
    public var boardSize: Size {
        return self.board.gridSize
    }

    public func colorIndex(at position: Point) -> Int? {
        if let value = self.block?.value(at: position) {
            return value
        }

        return board.value(at: position)
    }

    public func handleKeyCode(_ keyCode: KeyCode) {
        if let block = self.block, self.state.canHandleBlock {
            self.keyCodeHandlers[keyCode]?(block)
        }
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

    // MARK: - internal

    internal let board = Board(size: Size(width: 10, height: 20))
    internal var block: Block?
    internal var state: GameState = ReadyState() {
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

    // MARK: - private

    private lazy var keyCodeHandlers: [KeyCode: (BlockProtocol) -> Void] = {
        BlockAction.actionMap(with: self.board)
    } ()

}


private extension GameLogicController {

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
        self.block.map {
            if self.checkBlockDownCollision($0) {
                self.immobilize(block: $0)
                self.board.deleteFullRow()
            } else {
                $0.moveDown()
            }
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
        return [DirtyCheckable?](arrayLiteral: self.board, self.block).compactMap { $0 }
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
