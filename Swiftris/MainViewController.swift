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
    
    var boardView = BoardView(frame: NSRect(x: 10, y: 10, width: 100, height: 100))
    var logicController = GameLogicController()

    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        logicController.delegate = self
        
        println("MainViewController init(nibName, bundle)")
    }

    init(coder: NSCoder!) {
        super.init(coder: coder)

        logicController.delegate = self
        
        println("MainViewController init(coder)")
    }

    override func loadView() {
        super.loadView()
        
        println("MainViewController loadView")
        self.view.autoresizingMask = (NSAutoresizingMaskOptions.ViewWidthSizable | NSAutoresizingMaskOptions.ViewHeightSizable)
        
        var view = self.view as MainView
        view.delegate = self
        
        boardView.dataSource = self
        view.addSubview(boardView)
        boardView.setNeedsDisplayInRect(boardView.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  TODO : 이거 왜 안불리지?
        println("MainViewController viewDidLoad")
    }

    /*
     *  For Protocol
     */
    func eventOnView(view: NSView, didKeyDown keyCode: CUnsignedShort) {

        let keyCodeDict = [
            BKUpKeyCode : logicController.upArrowDown,
            BKRightKeyCode : logicController.rightArrowDown,
            BKLeftKeyCode : logicController.leftArrowDown,
            BKDownKeyCode : logicController.downArrowDown
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
        self.boardView.setNeedsDisplayInRect(boardView.bounds)
    }

}
