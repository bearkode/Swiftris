/*
 *  MainViewController.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa
import Logic


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
        self.timer = Timer.scheduledTimer(timeInterval: 1.0 / 30.0, target: self, selector: #selector(timeTick), userInfo: nil, repeats: true)
    }
    
    func timeTick() {
        self.logicController.timeTick()
    }

    // MARK: - private
    private let boardView = BoardView(frame: NSRect(x: 10, y: 10, width: 100, height: 100))
    private let logicController = GameLogicController()
    private var timer: Timer?
    
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
