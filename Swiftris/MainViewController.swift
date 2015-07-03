/*
 *  MainViewController.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa


class MainViewController: NSViewController, KeyboardEventDelegate, BoardViewDataSource, LogicControllerDelegate {
    
    // MARK: - Init
    
    required override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        logicController.delegate = self
        boardView.dataSource = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        logicController.delegate = self
        boardView.dataSource = self
    }
    
    // MARK: - Override
    /**
        Override
    */
    
    override func loadView() {
        super.loadView()
        
        if let view = self.view as? MainView {
            view.autoresizingMask = ([NSAutoresizingMaskOptions.ViewWidthSizable, NSAutoresizingMaskOptions.ViewHeightSizable])
            view.delegate = self
            view.addSubview(boardView)
        }
    }

    // MARK: - For Protocol
    /**
        For Protocol
    */
    func eventOnView(view: NSView, didKeyDown keyCode: BKKeyCode) {
        let keyCodeDict = [BKKeyCode.Up : logicController.upArrowDown,
                           BKKeyCode.Right : logicController.rightArrowDown,
                           BKKeyCode.Left : logicController.leftArrowDown,
                           BKKeyCode.Down : logicController.bottomArrowDown]
        
        if let function = keyCodeDict[keyCode] {
            function()
        }
    }
    
    func cellSizeOfBoardView(boardView: BoardView) -> CGSize {
        return CGSizeMake(20.0, 20.0)
    }
    
    func gridSizeOfBoardView(boardView: BoardView) -> GridSize {
        return logicController.boardGridSize
    }
    
    func colorIndexOfBoardView(boardView: BoardView, position: Point) -> Int {
        return logicController.colorIndexAtPosition(position)
    }
    
    func logicControllerDidUpdate(logicController: GameLogicController) {
        boardView.setNeedsDisplayInRect(boardView.bounds)
    }

    // MARK: - Privates

    private let boardView = BoardView(frame: NSRect(x: 10, y: 10, width: 100, height: 100))
    private let logicController = GameLogicController()

}
