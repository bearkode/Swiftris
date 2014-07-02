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

    func testIsOverlappedAtPosition() {
        var board = Board(size: GridSize(width: 30, height: 10))
        var block = BlockA()
        
        block.position = Point(x: 0, y: 6)
        XCTAssertTrue(board.isOverlappedAtPosition(block.lowPosition, block: block) == false, "")
        block.position = Point(x: 0, y: 7)
        XCTAssertTrue(board.isOverlappedAtPosition(block.lowPosition, block: block) == false, "")
        block.position = Point(x: 0, y: 8)
        XCTAssertTrue(board.isOverlappedAtPosition(block.lowPosition, block: block) == true, "")
        block.position = Point(x: 0, y: 9)
        XCTAssertTrue(board.isOverlappedAtPosition(block.lowPosition, block: block) == true, "")
    }

}