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
        let left = Grid(size: Size(width: 3, height: 3), array: [1, 1, 1, 2, 2, 2, 3, 3, 3], emptyValue: 0)
        let right = Grid(size: Size(width: 3, height: 3), array: [1, 1, 1, 2, 2, 2, 3, 3, 3], emptyValue: 0)
        
        XCTAssertTrue(left == right)
        
        right[2, 2] = 20
        XCTAssertFalse(left == right)
        
        left[2, 2] = 20
        XCTAssertTrue(left == right)
    }

    func testEnumerateInRange() {
        let grid = Grid(size: Size(width: 3, height: 3), array: [1, 1, 1, 2, 2, 2, 3, 3, 3], emptyValue: 0)
        
        let range = 3..<6
        grid.enumerate(inRange: range) { (point: Point, value: Int, stop: inout Bool) in
            XCTAssertTrue(point.y == 1, "")
            XCTAssertTrue(value == 2, "")
        }
    }
    
    func testEnumerateInRow() {
        let grid = Grid(size: Size(width: 3, height: 3), array: [1, 1, 1, 2, 2, 2, 3, 3, 3], emptyValue: 0)
        
        XCTAssertNotNil(grid, "")
        
        grid.enumerate(inRow: 1) { (point: Point, value: Int, stop: inout Bool) in
            XCTAssertTrue(point.y == 1, "")
            XCTAssertTrue(value == 2, "")
        }
    }
    
    func testEnumerateRowsFromTop() {
        let grid = Grid(size: Size(width: 5, height: 5), emptyValue: 0)
        
        var sum = 0
        grid.enumerateRowsFromTop { (row: Int) in
            sum += row
        }
        XCTAssertTrue(sum == (4 + 3 + 2 + 1 + 0))
    }

    func testReplaceRow() {
        let grid = Grid(size: Size(width: 3, height: 3), emptyValue: 0)
        
        XCTAssertNotNil(grid, "")
        
        grid.replace(with: [2, 3, 4,], forRow: 1)
        XCTAssertTrue(grid[0, 1] == 2, "")
        XCTAssertTrue(grid[1, 1] == 3, "")
        XCTAssertTrue(grid[2, 1] == 4, "")
    }
    
    func testIsOverlappedAtPosition() {
        let grid1 = Grid(size: Size(width: 5, height: 5), array: [0, 0, 0, 0, 0,
                                                                  0, 0, 0, 0, 0,
                                                                  0, 0, 0, 0, 0,
                                                                  0, 1, 0, 0, 0,
                                                                  0, 1, 1, 0, 0], emptyValue: 0)
        let grid2 = Grid(size: Size(width: 2, height: 2), array: [1, 1,
                                                                  0, 1], emptyValue: 0)

        XCTAssertFalse(grid1.isOverlapped(withGrid: grid2, position: Point(x: 1, y: 2)), "")
        XCTAssertTrue(grid1.isOverlapped(withGrid: grid2, position: Point(x: 1, y: 3)), "")
        XCTAssertTrue(grid1.isOverlapped(withGrid: grid2, position: Point(x: 0, y: 2)), "")
        XCTAssertTrue(grid1.isOverlapped(withGrid: grid2, position: Point(x: 3, y: 4)), "")
    }
    
    func testCompress() {
        let grid   = Grid(size: Size(width: 3, height: 3), array: [ 0, 0, 1, 2, 3, 4, 0, 0, 0], emptyValue: 0)
        let result = Grid(size: Size(width: 3, height: 3), array: [ 0, 0, 0, 0, 0, 1, 2, 3, 4], emptyValue: 0)
        
        XCTAssertFalse(grid == result)
        grid.compress(rowOver: 2)
        XCTAssertTrue(grid == result)
    }
    
    func testIsFullRow() {
        let grid = Grid(size: Size(width: 3, height: 3), array: [ 0, 0, 1, 2, 3, 4, 0, 0, 0], emptyValue: 0)
        
        XCTAssertTrue(grid.isFull(row: 0) == false)
        XCTAssertTrue(grid.isFull(row: 1) == true)
        XCTAssertTrue(grid.isFull(row: 2) == false)
    }
    
    func testCopyGrid() {
        let grid1 = Grid(size: Size(width: 5, height: 5), array: [0, 0, 0, 0, 0,
                                                                  0, 0, 0, 0, 0,
                                                                  0, 0, 0, 0, 0,
                                                                  0, 1, 0, 0, 0,
                                                                  0, 1, 1, 0, 0], emptyValue: 0)
        let grid2 = Grid(size: Size(width: 2, height: 2), array: [3, 3, 3, 3], emptyValue: 0)
        
        grid1.copy(from: grid2, position: Point(x: 3, y: 1))
        XCTAssertTrue(grid1[3, 1] == 3, "");
        XCTAssertTrue(grid1[4, 1] == 3, "");
        XCTAssertTrue(grid1[3, 2] == 3, "");
        XCTAssertTrue(grid1[4, 2] == 3, "");
        XCTAssertTrue(grid1[4, 3] != 3, "");
        XCTAssertTrue(grid1[2, 1] != 3, "");
    }
    
    
    func testSubscript() {
        let grid = Grid(size: Size(width: 3, height: 3), array: [ 0, 0, 0, 0, 0, 0, 0, 0, 0], emptyValue: 0)
        
        XCTAssertTrue(grid[2, 2] == 0)
        grid[2, 2] = 10
        XCTAssertTrue(grid[2, 2] == 10)
        
        XCTAssertTrue(grid[Point(x: 1, y: 0)] == 0)
        grid[Point(x: 1, y: 0)] = 1234
        XCTAssertTrue(grid[Point(x: 1, y: 0)] == 1234)

        XCTAssertTrue(grid[Point(x: 0, y: 0)] == 0)
        XCTAssertTrue(grid[Point(x: 1, y: 0)] == 1234)
        XCTAssertTrue(grid[Point(x: 2, y: 0)] == 0)
        XCTAssertTrue(grid[Point(x: 0, y: 1)] == 0)
        XCTAssertTrue(grid[Point(x: 1, y: 1)] == 0)
        XCTAssertTrue(grid[Point(x: 2, y: 1)] == 0)
        XCTAssertTrue(grid[Point(x: 0, y: 2)] == 0)
        XCTAssertTrue(grid[Point(x: 1, y: 2)] == 0)
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
