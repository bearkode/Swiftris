/*
 *  BoardTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 27..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import XCTest


class BoardTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGridSize() {
        let board = Board(size: GridSize(width: 10, height: 12))
        
        XCTAssertTrue(board.gridSize.width == 10)
        XCTAssertTrue(board.gridSize.height == 12)
    }
    
    func testValueAtPosition() {
        let board = Board(size: GridSize(width: 5, height: 5))
        let block = BlockA()
        
        block.position = Point(x: 0, y: 0)
        
        board.immobilzeBlock(block)
        
        XCTAssertTrue(board.valueAtPosition(Point(x: 0, y: 0)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 1, y: 0)) == 1)
        XCTAssertTrue(board.valueAtPosition(Point(x: 2, y: 0)) == 1)
        XCTAssertTrue(board.valueAtPosition(Point(x: 3, y: 0)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 4, y: 0)) == 0)

        XCTAssertTrue(board.valueAtPosition(Point(x: 0, y: 1)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 1, y: 1)) == 1)
        XCTAssertTrue(board.valueAtPosition(Point(x: 2, y: 1)) == 1)
        XCTAssertTrue(board.valueAtPosition(Point(x: 3, y: 1)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 4, y: 1)) == 0)

        XCTAssertTrue(board.valueAtPosition(Point(x: 0, y: 2)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 1, y: 2)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 2, y: 2)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 3, y: 2)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 4, y: 2)) == 0)

        XCTAssertTrue(board.valueAtPosition(Point(x: 0, y: 3)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 1, y: 3)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 2, y: 3)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 3, y: 3)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 4, y: 3)) == 0)

        XCTAssertTrue(board.valueAtPosition(Point(x: 0, y: 4)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 1, y: 4)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 2, y: 4)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 3, y: 4)) == 0)
        XCTAssertTrue(board.valueAtPosition(Point(x: 4, y: 4)) == 0)
    }
    
    func testIsPossiblePosition() {
        let board = Board(size: GridSize(width: 5, height: 5))
        let block = BlockD()
        let other = BlockE()
        
        block.position = Point(x: 0, y: 2)
        board.immobilzeBlock(block)
        
        XCTAssertTrue(board.isPossiblePosition(Point(x: 2, y: 2), block: other))
        XCTAssertFalse(board.isPossiblePosition(Point(x: 2, y: 1), block: other))
        XCTAssertFalse(board.isPossiblePosition(Point(x: 3, y: 2), block: other))
        XCTAssertTrue(board.isPossiblePosition(Point(x: 2, y: 3), block: other))
    }

    func testIsOverlappedAtPosition() {
        let board = Board(size: GridSize(width: 30, height: 10))
        let block = BlockA()
        
        block.position = Point(x: 0, y: 6)
        XCTAssertTrue(board.isOverlappedAtPosition(block.position.underPoint, block: block) == false, "")
        block.position = Point(x: 0, y: 7)
        XCTAssertTrue(board.isOverlappedAtPosition(block.position.underPoint, block: block) == false, "")
        block.position = Point(x: 0, y: 8)
        XCTAssertTrue(board.isOverlappedAtPosition(block.position.underPoint, block: block) == true, "")
        block.position = Point(x: 0, y: 9)
        XCTAssertTrue(board.isOverlappedAtPosition(block.position.underPoint, block: block) == true, "")
    }

}
