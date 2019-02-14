//
//  BlockAction.swift
//  Logic
//
//  Created by bearkode on 12/02/2019.
//  Copyright © 2019 bearkode. All rights reserved.
//

import Foundation


internal enum BlockAction {

    internal typealias Action = (BlockProtocol) -> Void
    internal typealias RawFunction = (BlockProtocol, BoardProtocol) -> Void

    internal static func actionMap(with board: BoardProtocol) -> [KeyCode: Action] {
        return [.up: curry(BlockAction.turn)(board),
                .left: curry(BlockAction.moveLeft)(board),
                .right: curry(BlockAction.moveRight)(board)]
    }

    // MARK: - private

    private static func turn(board: BoardProtocol, block: BlockProtocol) {
        if board.isPossible(at: block.position, withGrid: block.nextShape) {
            block.turn()
        }
    }

    private static func moveLeft(board: BoardProtocol, block: BlockProtocol) {
        if board.isPossible(at: block.position.leftPoint, withGrid: block.currentShape) {
            block.moveLeft()
        }
    }

    private static func moveRight(board: BoardProtocol, block: BlockProtocol) {
        if board.isPossible(at: block.position.rightPoint, withGrid: block.currentShape) {
            block.moveRight()
        }
    }

}
