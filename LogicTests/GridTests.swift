/*
 *  GridTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 25..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import XCTest
@testable import Logic


class GridTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testEqual() {
        let left = Grid(size: Size(width: 3, height: 3), array: [1, 1, 1, 2, 2, 2, 3, 3, 3])
        let right = Grid(size: Size(width: 3, height: 3), array: [1, 1, 1, 2, 2, 2, 3, 3, 3])

        XCTAssertTrue(left == right)

        right[2, 2] = 20
        XCTAssertFalse(left == right)

        left[2, 2] = 20
        XCTAssertTrue(left == right)
    }

    func testEnumerateRowsFromTop() {
        let grid = Grid<Int>(size: Size(width: 5, height: 5))

        var sum = 0
        grid.rows.forEach {
            sum += $0.index
        }
        XCTAssertTrue(sum == (4 + 3 + 2 + 1 + 0))
    }

    func testReplaceRow() {
        let grid = Grid<Int>(size: Size(width: 3, height: 3))

        XCTAssertNotNil(grid, "")

        grid.replace(with: [2, 3, 4], forRow: 1)
        XCTAssertTrue(grid[0, 1] == 2, "")
        XCTAssertTrue(grid[1, 1] == 3, "")
        XCTAssertTrue(grid[2, 1] == 4, "")
    }

    func testIsOverlappedAtPosition() {
        let grid1 = Grid(size: Size(width: 5, height: 5), array: [0, 0, 0, 0, 0,
                                                                  0, 0, 0, 0, 0,
                                                                  0, 0, 0, 0, 0,
                                                                  0, 1, 0, 0, 0,
                                                                  0, 1, 1, 0, 0].map(conv))
        let grid2 = Grid(size: Size(width: 2, height: 2), array: [1, 1,
                                                                  0, 1].map(conv))

        XCTAssertFalse(grid1.isOverlapped(withGrid: grid2, position: Point(x: 1, y: 2)))
        XCTAssertTrue(grid1.isOverlapped(withGrid: grid2, position: Point(x: 1, y: 3)))
        XCTAssertTrue(grid1.isOverlapped(withGrid: grid2, position: Point(x: 0, y: 2)))
        XCTAssertTrue(grid1.isOverlapped(withGrid: grid2, position: Point(x: 3, y: 4)))
        XCTAssertTrue(grid1.isOverlapped(withGrid: grid2, position: Point(x: 4, y: 1)))
    }

    func testCompress() {
        let grid   = Grid(size: Size(width: 3, height: 3), array: [0, 0, 1, 2, 3, 4, 0, 0, 0].map(conv))
        let result = Grid(size: Size(width: 3, height: 3), array: [0, 0, 0, 0, 0, 1, 2, 3, 4].map(conv))

        XCTAssertFalse(grid == result)
        grid.compress(rowOver: 2)
        XCTAssertTrue(grid == result)
    }
    
    func testPointsHasValue() {
        let grid = Grid(size: Size(width: 3, height: 3), array: [0, 0, 1,
                                                                 2, 3, 4,
                                                                 0, 0, 0].map(conv))
        let points = grid.size.points
        let pointsHasValue = grid.pointsHasValue

        XCTAssertTrue(points.count == 9)
        XCTAssertTrue(pointsHasValue.count == 4)
        XCTAssertTrue(pointsHasValue.contains(Point(x: 2, y: 0)))
        XCTAssertTrue(pointsHasValue.contains(Point(x: 0, y: 1)))
        XCTAssertTrue(pointsHasValue.contains(Point(x: 1, y: 1)))
        XCTAssertTrue(pointsHasValue.contains(Point(x: 2, y: 1)))
    }

    func testCopyGrid() {
        let grid1 = Grid(size: Size(width: 5, height: 5), array: [0, 0, 0, 0, 0,
                                                                  0, 0, 0, 0, 0,
                                                                  0, 0, 0, 0, 0,
                                                                  0, 1, 0, 0, 0,
                                                                  0, 1, 1, 0, 0].map(conv))
        let grid2 = Grid(size: Size(width: 2, height: 2), array: [3, 3, 3, 3])

        grid1.copy(from: grid2, position: Point(x: 3, y: 1))
        XCTAssertTrue(grid1[3, 1] == 3, "")
        XCTAssertTrue(grid1[4, 1] == 3, "")
        XCTAssertTrue(grid1[3, 2] == 3, "")
        XCTAssertTrue(grid1[4, 2] == 3, "")
        XCTAssertTrue(grid1[4, 3] != 3, "")
        XCTAssertTrue(grid1[2, 1] != 3, "")
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

    func testGetRangeOfRow() {

    }

    func testValidateCoordinate() {

    }

    func testGetIndexFrom() {

    }

    func testGetPositionWithIndex() {

    }

}
