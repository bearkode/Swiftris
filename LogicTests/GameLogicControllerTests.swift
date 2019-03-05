/*
 *  GameLogicControllerTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2017. 6. 21..
 *  Copyright © 2017 bearkode. All rights reserved.
 *
 */

import XCTest
@testable import Logic


class GameLogicControllerTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    var startExpectation: XCTestExpectation?
    var pauseExpectation: XCTestExpectation?
    var resumeExpectation: XCTestExpectation?
    var gameoverExpectation: XCTestExpectation?

    func testBasic() {
        let controller = GameLogicController()

        XCTAssertNil(controller.delegate)
        XCTAssertTrue(controller.boardSize == Size(width: 10, height: 20))

        controller.delegate = self

        controller.boardSize.points.forEach {
            let colorIndex = controller.colorIndex(at: $0)
            XCTAssertNil(colorIndex)
        }
        
        XCTAssertTrue(controller.startButtonTitle == "START")

        self.generateTimeTick(to: controller, count: 100)

        XCTAssertTrue(controller.startButtonTitle == "START")

        self.startExpectation = self.expectation(description: "start")
        controller.startButtonClicked()
        self.waitForExpectations(timeout: 1.0, handler: nil)

        XCTAssertTrue(controller.startButtonTitle == "PAUSE")

        self.generateTimeTick(to: controller, count: 1)

        XCTAssertNotNil(controller.block)
        if let block = controller.block {
            controller.boardSize.points
                .compactMap { (p: Point) -> (Point, Int)? in
                    guard let index = block.value(at: p) else {
                        return nil
                    }

                    return (p, index)
                }
                .forEach {
                    XCTAssertNotNil(controller.colorIndex(at: $0.0) == $0.1)
                }
        }

        self.generateTimeTick(to: controller, count: 10)

        self.pauseExpectation = self.expectation(description: "pause")
        controller.startButtonClicked() //  TODO: startButtonClicked라는 메소드명이 어색함
        self.waitForExpectations(timeout: 1.0, handler: nil)

        XCTAssertTrue(controller.startButtonTitle == "RESUME")

        self.generateTimeTick(to: controller, count: 10)
        XCTAssertTrue(controller.startButtonTitle == "RESUME")

        self.resumeExpectation = self.expectation(description: "resume")
        controller.startButtonClicked()
        self.waitForExpectations(timeout: 1.0, handler: nil)

        XCTAssertTrue(controller.startButtonTitle == "PAUSE")

        self.gameoverExpectation = self.expectation(description: "gameover")
        self.generateTimeTick(to: controller, count: 1000)
        self.waitForExpectations(timeout: 1.0, handler: nil)

        XCTAssertTrue(controller.startButtonTitle == "START")        
    }

    func testHandleKey() {
        let controller = GameLogicController()
        controller.delegate = self

        controller.startButtonClicked()

        self.generateTimeTick(to: controller, count: 1)

        guard let block1 = controller.block else {
            XCTAssert(false)
            return
        }

        var pos1 = block1.position
        pos1.x -= 1

        controller.handleKeyCode(.left)
        XCTAssertTrue(pos1 == block1.position)

        pos1.x += 1
        controller.handleKeyCode(.right)
        XCTAssertTrue(pos1 == block1.position)

        let nextRotateIndex = block1.nextRotateIndex

        controller.handleKeyCode(.up)
        XCTAssertTrue(block1.rotateIndex == nextRotateIndex)
    }

}


extension GameLogicControllerTests {

    func generateTimeTick(to controller: GameLogicController, count: Int) {
        for _ in (0..<count) {
            controller.timeTick()
        }
    }

}


extension GameLogicControllerTests: LogicControllerDelegate {

    func logicControllerDidStartGame(_ logicController: GameLogicController) {
        self.startExpectation?.fulfill()
    }

    func logicControllerDidPause(_ logicController: GameLogicController) {
        self.pauseExpectation?.fulfill()
    }

    func logicControllerDidResume(_ logicController: GameLogicController) {
        self.resumeExpectation?.fulfill()
    }

    func logicControllerDidGameOver(_ logicController: GameLogicController) {
        self.gameoverExpectation?.fulfill()
    }

    func logicControllerDidUpdate(_ logicController: GameLogicController) {

    }
    
}
