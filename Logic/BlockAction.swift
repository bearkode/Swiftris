//
//  BlockAction.swift
//  Logic
//
//  Created by bearkode on 12/02/2019.
//  Copyright © 2019 bearkode. All rights reserved.
//

import Foundation


internal enum BlockAction {

    internal static func actionMap(with board: Board) -> [KeyCode: (Block) -> Void] {
        return [.up: BlockAction.action(for: board, with: BlockAction.turn(block:board:)),
                .right: BlockAction.action(for: board, with: BlockAction.moveRight(block:board:)),
                .left: BlockAction.action(for: board, with: BlockAction.moveLeft(block:board:))]
    }

    private static func action(for board: Board, with function: @escaping (Block, Board) -> Void) -> (Block) -> Void {
        return { block in
            function(block, board)
        }
    }

    private static func turn(block: Block, board: Board) {
        if board.isPossible(at: block.position, withGrid: block.nextShape) {
            block.turn()
        }
    }

    private static func moveLeft(block: Block, board: Board) {
        if board.isPossible(at: block.position.leftPoint, withGrid: block.currentShape) {
            block.moveLeft()
        }
    }

    private static func moveRight(block: Block, board: Board) {
        if board.isPossible(at: block.position.rightPoint, withGrid: block.currentShape) {
            block.moveRight()
        }
    }

}
