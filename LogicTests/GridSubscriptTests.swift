//
//  GridSubscriptTests.swift
//  LogicTests
//
//  Created by bearkode on 14/02/2019.
//  Copyright © 2019 bearkode. All rights reserved.
//

import XCTest
@testable import Logic


class GridSubscriptTests: XCTestCase {

    override func setUp() {

    }

    override func tearDown() {

    }

    func testSubscript() {
        let grid = Grid(size: Size(width: 3, height: 3), array: [ 0, 0, 0, 0, 0, 0, 0, 0, 0].map(conv))

        XCTAssertTrue(grid[2, 2] == nil)
        grid[2, 2] = 10
        XCTAssertTrue(grid[2, 2] == 10)

        XCTAssertTrue(grid[Point(x: 1, y: 0)] == nil)
        grid[Point(x: 1, y: 0)] = 1234
        XCTAssertTrue(grid[Point(x: 1, y: 0)] == 1234)

        XCTAssertTrue(grid[Point(x: 0, y: 0)] == nil)
        XCTAssertTrue(grid[Point(x: 1, y: 0)] == 1234)
        XCTAssertTrue(grid[Point(x: 2, y: 0)] == nil)
        XCTAssertTrue(grid[Point(x: 0, y: 1)] == nil)
        XCTAssertTrue(grid[Point(x: 1, y: 1)] == nil)
        XCTAssertTrue(grid[Point(x: 2, y: 1)] == nil)
        XCTAssertTrue(grid[Point(x: 0, y: 2)] == nil)
        XCTAssertTrue(grid[Point(x: 1, y: 2)] == nil)
        XCTAssertTrue(grid[Point(x: 2, y: 2)] == 10)
    }

    func testSubscriptFail() {
        let grid = Grid<Int>(size: Size(width: 10, height: 10))

        self.expectAssertFail(expectedMessage: "Index out of range") {
            _ = grid[-1, 0]
        }
        self.expectAssertFail(expectedMessage: "Index out of range") {
            _ = grid[4, 10]
        }
    }

}
