/*
 *  MainViewController.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa


let BKUpKeyCode: CUnsignedShort = 126
let BKDownKeyCode: CUnsignedShort = 125
let BKLeftKeyCode: CUnsignedShort = 123
let BKRightKeyCode: CUnsignedShort = 124


class MainViewController: NSViewController, KeyboardEventDelegate, BoardViewDataSource, LogicControllerDelegate {
    
    required override init?(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        logicController.delegate = self
        boardView.dataSource = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        logicController.delegate = self
        boardView.dataSource = self
    }

    override func loadView() {
        super.loadView()
        
        let view = self.view as MainView
        view.autoresizingMask = (NSAutoresizingMaskOptions.ViewWidthSizable | NSAutoresizingMaskOptions.ViewHeightSizable)
        view.delegate = self
        view.addSubview(boardView)
    }

    /*
     *  For Protocol
     */
    func eventOnView(view: NSView, didKeyDown keyCode: CUnsignedShort) {
        let keyCodeDict = [
            BKUpKeyCode : logicController.upArrowDown,
            BKRightKeyCode : logicController.rightArrowDown,
            BKLeftKeyCode : logicController.leftArrowDown,
            BKDownKeyCode : logicController.bottomArrowDown
        ]
        
        if let function = keyCodeDict[keyCode] {
            function()
        }
    }
    
    func getCellSizeOfBoardView(boardView: BoardView) -> CGSize! {
        return CGSizeMake(20.0, 20.0)
    }
    
    func getGridSizeOfBoardView(boardView: BoardView) -> GridSize! {
        return logicController.boardGridSize
    }
    
    func getColorIndexOfBoardView(boardView: BoardView, position: Point) -> Int!  {
        return logicController.colorIndexAtPosition(position)
    }
    
    func logicControllerDidUpdate(logicController: GameLogicController) {
        boardView.setNeedsDisplayInRect(boardView.bounds)
    }

    /*
     *  Privates
     */
    let boardView = BoardView(frame: NSRect(x: 10, y: 10, width: 100, height: 100))
    let logicController = GameLogicController()

}
