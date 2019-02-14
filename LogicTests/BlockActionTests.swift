//
//  BlockActionTests.swift
//  LogicTests
//
//  Created by bearkode on 14/02/2019.
//  Copyright © 2019 bearkode. All rights reserved.
//

import XCTest
@testable import Logic


class BlockActionTests: XCTestCase {

    override func setUp() {

    }

    override func tearDown() {

    }

    var isPossible = false

    var turnCalled = false
    var moveLeftCalled = false
    var moveRightCalled = false

    func resetCalled() {
        self.turnCalled = false
        self.moveLeftCalled = false
        self.moveRightCalled = false
    }

    func testBasic() {
        let action = BlockAction.actionMap(with: self)

        XCTAssertNotNil(action[.up])
        XCTAssertNotNil(action[.right])
        XCTAssertNotNil(action[.left])

        self.isPossible = true
        self.resetCalled()
        action[.up]?(self)
        XCTAssertTrue(self.turnCalled)
        XCTAssertFalse(self.moveLeftCalled)
        XCTAssertFalse(self.moveRightCalled)

        self.isPossible = true
        self.resetCalled()
        action[.left]?(self)
        XCTAssertFalse(self.turnCalled)
        XCTAssertTrue(self.moveLeftCalled)
        XCTAssertFalse(self.moveRightCalled)

        self.isPossible = true
        self.resetCalled()
        action[.right]?(self)
        XCTAssertFalse(self.turnCalled)
        XCTAssertFalse(self.moveLeftCalled)
        XCTAssertTrue(self.moveRightCalled)

        self.isPossible = false
        self.resetCalled()
        action[.up]?(self)
        XCTAssertFalse(self.turnCalled)
        XCTAssertFalse(self.moveLeftCalled)
        XCTAssertFalse(self.moveRightCalled)

        self.isPossible = false
        self.resetCalled()
        action[.left]?(self)
        XCTAssertFalse(self.turnCalled)
        XCTAssertFalse(self.moveLeftCalled)
        XCTAssertFalse(self.moveRightCalled)

        self.isPossible = false
        self.resetCalled()
        action[.right]?(self)
        XCTAssertFalse(self.turnCalled)
        XCTAssertFalse(self.moveLeftCalled)
        XCTAssertFalse(self.moveRightCalled)
    }

}


extension BlockActionTests: BoardProtocol {

    func isPossible(at: Point, withGrid: Grid<Int>) -> Bool {
        return self.isPossible
    }

}


extension BlockActionTests: BlockProtocol {

    var position: Point {
        return .zero
    }

    var currentShape: Grid<Int> {
        return Grid<Int>(size: Size(width: 4, height: 4))
    }

    var nextShape: Grid<Int> {
        return Grid<Int>(size: Size(width: 4, height: 4))
    }

    func turn() {
        self.turnCalled = true
    }

    func moveLeft() {
        self.moveLeftCalled = true
    }

    func moveRight() {
        self.moveRightCalled = true
    }

}
