/*
 *  GridTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 25..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import XCTest


class GridTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testReplaceRow() {
        var grid = Grid(width: 3, height: 3)
        
        XCTAssertNotNil(grid, "")
        
        grid.replaceRow(1, array: [2, 3, 4,])
        XCTAssertTrue(grid[0, 1] == 2, "")
        XCTAssertTrue(grid[1, 1] == 3, "")
        XCTAssertTrue(grid[2, 1] == 4, "")
    }
    
    func testEnumerateRow() {
        var grid = Grid(width: 3, height: 3, array: [1, 1, 1, 2, 2, 2, 3, 3, 3])
        
        XCTAssertNotNil(grid, "")
        
        grid.enumerateRow(1) { (x: Int, y: Int, value: Int, inout stop: Bool) in
            XCTAssertTrue(y == 1, "")
            XCTAssertTrue(value == 2, "")
        }
    }
    
    func testIsOverlappedAtPosition() {
        var grid1 = Grid(width: 5, height: 5, array: [0, 0, 0, 0, 0,
                                                      0, 0, 0, 0, 0,
                                                      0, 0, 0, 0, 0,
                                                      0, 1, 0, 0, 0,
                                                      0, 1, 1, 0, 0])
        var grid2 = Grid(width: 2, height: 2, array: [1, 1,
                                                      0, 1])

        XCTAssertFalse(grid1.isOverlappedAtPosition(Point(x: 1, y: 2), grid: grid2), "")
        XCTAssertTrue(grid1.isOverlappedAtPosition(Point(x: 1, y: 3), grid: grid2), "")
        XCTAssertTrue(grid1.isOverlappedAtPosition(Point(x: 0, y: 2), grid: grid2), "")

    }
    
}
