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
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        
        DispatchQueue.main.async {
            self.setup()
            self.setupMainView()
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0 / 30.0, target: self, selector: #selector(timeTick), userInfo: nil, repeats: true)
    }
    
    // MARK: - outlets
    @IBOutlet var startButton: NSButton?
    
    // MARK: - actions
    @IBAction func startButtonClicked(sender: AnyObject) {
        self.logicController.startButtonClicked()
    }
    
    func timeTick() {
        self.logicController.timeTick()
    }

    // MARK: - private
    fileprivate let boardView = BoardView(frame: NSRect(x: 10, y: 10, width: 100, height: 100))
    fileprivate let logicController = GameLogicController()
    private var timer: Timer?
    
}


fileprivate extension MainViewController {

    func setup() {
        self.logicController.delegate = self
        self.boardView.dataSource = self
        self.boardView.delegate = self
    }
    
    func setupMainView() {
        guard let view = self.view as? MainView else {
            return
        }
        
        view.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        view.delegate = self
        view.addSubview(self.boardView)
    }

}


extension MainViewController: BoardViewDelegate {

    func boardView(didChangeFrame frame: CGRect) {
        guard let window = self.view.window else {
            return
        }
        
        let origin = window.frame.origin
        
        window.setFrame(CGRect(x: origin.x, y: origin.y, width: frame.size.width + 120, height: frame.size.height + 40), display: true)
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

    func logicControllerDidStartGame(_ logicController: GameLogicController) {
        self.startButton?.title = self.logicController.startButtonTitle
    }

    func logicControllerDidPause(_ logicController: GameLogicController) {
        self.startButton?.title = self.logicController.startButtonTitle
    }
    
    func logicControllerDidResume(_ logicController: GameLogicController) {
        self.startButton?.title = self.logicController.startButtonTitle
    }
    
    func logicControllerDidGameOver(_ logicController: GameLogicController) {
        self.startButton?.title = self.logicController.startButtonTitle
    }

    func logicControllerDidUpdate(_ logicController: GameLogicController) {
        self.boardView.setNeedsDisplay(boardView.bounds)
    }

}
