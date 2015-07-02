/*
 *  BlockTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 26..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import XCTest


class BlockTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testContains() {
        let block = BlockA()
        block.position = Point(x: 3, y: 3)

        XCTAssertFalse(block.containsPosition(Point(x: 2, y: 2)), "")
        XCTAssertFalse(block.containsPosition(Point(x: 2, y: 3)), "")
        XCTAssertFalse(block.containsPosition(Point(x: 7, y: 2)), "")
        XCTAssertFalse(block.containsPosition(Point(x: 7, y: 3)), "")
        XCTAssertFalse(block.containsPosition(Point(x: 2, y: 7)), "")
        XCTAssertFalse(block.containsPosition(Point(x: 3, y: 7)), "")
        XCTAssertFalse(block.containsPosition(Point(x: 7, y: 7)), "")
        XCTAssertFalse(block.containsPosition(Point(x: 6, y: 7)), "")
        XCTAssertFalse(block.containsPosition(Point(x: 7, y: 6)), "")
    }
    
    func testBlockPositionFromPosition()
    {
        let block = Block.randomBlock()
        block.position = Point(x: 10, y: 15)
        
        XCTAssertTrue((block.blockPositionFromPosition(Point(x: 10, y: 15)) == Point(x: 0, y: 0)), "")
        XCTAssertTrue((block.blockPositionFromPosition(Point(x: 10, y: 16)) == Point(x: 0, y: 1)), "")
        XCTAssertTrue((block.blockPositionFromPosition(Point(x: 13, y: 17)) == Point(x: 3, y: 2)), "")
    }
    
    func testValueAtPosition() {
        let block = BlockA()
        block.position = Point(x: 5, y: 5)
        
        XCTAssertTrue(block.valueAtPosition(Point(x: 0, y: 4)) == 0, "")
        XCTAssertTrue(block.valueAtPosition(Point(x: 4, y: 4)) == 0, "")
        XCTAssertTrue(block.valueAtPosition(Point(x: 5, y: 5)) == 0, "")
        XCTAssertTrue(block.valueAtPosition(Point(x: 5, y: 6)) == 0, "")
        XCTAssertTrue(block.valueAtPosition(Point(x: 6, y: 5)) == 1, "")
        XCTAssertTrue(block.valueAtPosition(Point(x: 7, y: 5)) == 1, "")
        XCTAssertTrue(block.valueAtPosition(Point(x: 6, y: 6)) == 1, "")
        XCTAssertTrue(block.valueAtPosition(Point(x: 7, y: 6)) == 1, "")
        XCTAssertTrue(block.valueAtPosition(Point(x: 6, y: 7)) == 0, "")
        XCTAssertTrue(block.valueAtPosition(Point(x: 7, y: 7)) == 0, "")
        XCTAssertTrue(block.valueAtPosition(Point(x: 8, y: 5)) == 0, "")
        XCTAssertTrue(block.valueAtPosition(Point(x: 8, y: 6)) == 0, "")
        
    }

}
