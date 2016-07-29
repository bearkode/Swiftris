/*
 *  MainViewController.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa


class MainViewController: NSViewController {
    
    // MARK: - init
    required override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupMainView()
    }

    // MARK: - private
    private let boardView = BoardView(frame: NSRect(x: 10, y: 10, width: 100, height: 100))
    private let logicController = GameLogicController()
    
}


private extension MainViewController {

    private func setup() {
        self.logicController.delegate = self
        self.boardView.dataSource = self
    }
    
    private func setupMainView() {
        guard let view = self.view as? MainView else {
            return
        }
        
        view.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        view.delegate = self
        view.addSubview(self.boardView)
    }

}


extension MainViewController: BoardViewDataSource {

    func cellSizeOfBoardView(_ boardView: BoardView) -> CGSize {
        return CGSize(width: 20.0, height: 20.0)
    }
    
    func gridSizeOfBoardView(_ boardView: BoardView) -> GridSize {
        return self.logicController.boardSize
    }
    
    func colorIndexOfBoardView(_ boardView: BoardView, position: Point) -> Int {
        return self.logicController.colorIndex(at: position)
    }

}


extension MainViewController: KeyboardEventDelegate {

    func eventOnView(_ view: NSView, didKeyDown keyCode: KeyCode) {
        self.logicController.handleKeyCode(keyCode)
    }

}


extension MainViewController: LogicControllerDelegate {

    func logicControllerDidUpdate(_ logicController: GameLogicController) {
        self.boardView.setNeedsDisplay(boardView.bounds)
    }

}
