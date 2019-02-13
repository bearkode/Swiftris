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

    override required init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - override

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.autoresizingMask = [.width, .height]

        DispatchQueue.main.async {
            self.setup()
            self.setupMainView()
        }

        self.timer = Timer.scheduledTimer(timeInterval: 1.0 / 30.0,
                                          target: self,
                                          selector: #selector(self.timeTick),
                                          userInfo: nil,
                                          repeats: true)
    }

    // MARK: - outlets

    @IBOutlet private var startButton: NSButton?

    // MARK: - actions

    @IBAction private func startButtonClicked(sender: Any) {
        self.logicController.startButtonClicked()
    }

    @objc func timeTick() {
        self.logicController.timeTick()
    }

    // MARK: - private

    private let boardView = BoardView(frame: NSRect(x: 10, y: 10, width: 100, height: 100))
    private let logicController = GameLogicController()
    private var timer: Timer?

}


private extension MainViewController {

    func setup() {
        self.logicController.delegate = self
        self.boardView.dataSource = self
        self.boardView.delegate = self
    }

    func setupMainView() {
        guard let view = self.view as? MainView else {
            return
        }

        view.autoresizingMask = [.width, .height]
        view.delegate = self
        view.addSubview(self.boardView)
    }

}


extension MainViewController: BoardViewDelegate {

    func boardView(didChangeFrame frame: CGRect) {
        self.view.window.map {
            let origin = $0.frame.origin
            let width = frame.size.width + 120
            let height = frame.size.height + 40
            $0.setFrame(CGRect(x: origin.x, y: origin.y, width: width, height: height), display: true)
        }
    }

}


extension MainViewController: BoardViewDataSource {

    func cellSizeOfBoardView(_ boardView: BoardView) -> CGSize {
        return CGSize(width: 20.0, height: 20.0)
    }

    func gridSizeOfBoardView(_ boardView: BoardView) -> Size {
        return self.logicController.boardSize
    }

    func colorIndexOfBoardView(_ boardView: BoardView, position: Point) -> Int {
        return self.logicController.colorIndex(at: position) ?? 0
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
