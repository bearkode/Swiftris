/*
 *  GameLogicController.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 17..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class GameLogicController : BoardViewDataSource {
    
    var bloard = Board(size: CGSize(width: 20, height: 30))
    var block = BlockE()
    
    init () {
    
    }
    
    func upArrowDown() {
        block.turn()
        block.debugPrint()
    }

    func leftArrowDown() {
        block.moveLeft()
    }

    func rightArrowDown() {
        block.moveRight()
    }
    
    func downArrowDown() {
        // TODO : do drop logic
    }
    
    func getCellSizeOfBoardView(boardView: BoardView) -> CGSize!
    {
        return CGSize(width: 30, height: 20)
    }
    
    func getGridSizeOfBoardView(boardView: BoardView) -> CGSize!
    {
        return CGSize(width: 10, height: 10)
    }

}