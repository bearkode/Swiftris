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

    func testEnumerateGrid() {
        let grid = Grid(width: 3, height: 3, array: [1, 1, 1, 2, 2, 2, 3, 3, 3])
        
        grid.enumerateGrid(3...5) { (point: Point, value: Int, inout stop: Bool) in
            XCTAssertTrue(point.y == 1, "")
            XCTAssertTrue(value == 2, "")
        }
    }
    
    func testEnumerateRow() {
        let grid = Grid(width: 3, height: 3, array: [1, 1, 1, 2, 2, 2, 3, 3, 3])
        
        XCTAssertNotNil(grid, "")
        
        grid.enumerateRow(1) { (point: Point, value: Int, inout stop: Bool) in
            XCTAssertTrue(point.y == 1, "")
            XCTAssertTrue(value == 2, "")
        }
    }

    func testReplaceRow() {
        let grid = Grid(width: 3, height: 3)
        
        XCTAssertNotNil(grid, "")
        
        grid.replaceRow(1, array: [2, 3, 4,])
        XCTAssertTrue(grid[0, 1] == 2, "")
        XCTAssertTrue(grid[1, 1] == 3, "")
        XCTAssertTrue(grid[2, 1] == 4, "")
    }
    
    func testIsOverlappedAtPosition() {
        let grid1 = Grid(width: 5, height: 5, array: [0, 0, 0, 0, 0,
                                                      0, 0, 0, 0, 0,
                                                      0, 0, 0, 0, 0,
                                                      0, 1, 0, 0, 0,
                                                      0, 1, 1, 0, 0])
        let grid2 = Grid(width: 2, height: 2, array: [1, 1,
                                                      0, 1])

        XCTAssertFalse(grid1.isOverlappedGrid(grid2, position: Point(x: 1, y: 2)), "")
        XCTAssertTrue(grid1.isOverlappedGrid(grid2, position: Point(x: 1, y: 3)), "")
        XCTAssertTrue(grid1.isOverlappedGrid(grid2, position: Point(x: 0, y: 2)), "")
        XCTAssertTrue(grid1.isOverlappedGrid(grid2, position: Point(x: 3, y: 4)), "")
    }
    
    func testCompactRowOver() {
    
    }
    
    func testIsFullRow() {
    
    }
    
    func testCopyGrid() {
        let grid1 = Grid(width: 5, height: 5, array: [0, 0, 0, 0, 0,
                                                      0, 0, 0, 0, 0,
                                                      0, 0, 0, 0, 0,
                                                      0, 1, 0, 0, 0,
                                                      0, 1, 1, 0, 0])
        let grid2 = Grid(width: 2, height: 2, array: [3, 3, 3, 3])
        
        grid1.copyGrid(grid2, position: Point(x: 3, y: 1))
        XCTAssertTrue(grid1[3, 1] == 3, "");
        XCTAssertTrue(grid1[4, 1] == 3, "");
        XCTAssertTrue(grid1[3, 2] == 3, "");
        XCTAssertTrue(grid1[4, 2] == 3, "");
        XCTAssertTrue(grid1[4, 3] != 3, "");
        XCTAssertTrue(grid1[2, 1] != 3, "");
    }
    
    
    func testSubscript() {
    
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
