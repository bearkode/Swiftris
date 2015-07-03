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
        XCTAssertTrue(block.valueAtPosition(Point(x: 10, y: 10)) == 0, "")
    }

    let grid0 = Grid(width: 4, height: 4, array: [0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 3, 0])
    let grid3 = Grid(width: 4, height: 4, array: [3, 3, 3, 0, 3, 0, 0, 0])
    let grid2 = Grid(width: 4, height: 4, array: [0, 3, 0, 0, 0, 3, 0, 0, 0, 3, 3, 0])
    let grid1 = Grid(width: 4, height: 4, array: [0, 0, 3, 0, 3, 3, 3, 0])
    
    func testTurn() {
        let block = BlockC()

        XCTAssertTrue(block.currentGrid == grid0)
        block.turn()
        XCTAssertTrue(block.currentGrid == grid3)
        block.turn()
        XCTAssertTrue(block.currentGrid == grid2)
        block.turn()
        XCTAssertTrue(block.currentGrid == grid1)
        block.turn()
        XCTAssertTrue(block.currentGrid == grid0)
        block.turn()
        XCTAssertTrue(block.currentGrid == grid3)
        block.turn()
        XCTAssertTrue(block.currentGrid == grid2)
        block.turn()
        XCTAssertTrue(block.currentGrid == grid1)
        block.turn()
        XCTAssertTrue(block.currentGrid == grid0)
    }
    
    func testNextGrid() {
        let block = BlockC()

        XCTAssertTrue(block.currentGrid == grid0)
        XCTAssertTrue(block.nextGrid == grid3)
        
        block.turn()
        XCTAssertTrue(block.currentGrid == grid3)
        XCTAssertTrue(block.nextGrid == grid2)
        
        block.turn()
        XCTAssertTrue(block.currentGrid == grid2)
        XCTAssertTrue(block.nextGrid == grid1)

        block.turn()
        XCTAssertTrue(block.currentGrid == grid1)
        XCTAssertTrue(block.nextGrid == grid0)

        block.turn()
        XCTAssertTrue(block.currentGrid == grid0)
        XCTAssertTrue(block.nextGrid == grid3)
        
        block.turn()
        XCTAssertTrue(block.currentGrid == grid3)
        XCTAssertTrue(block.nextGrid == grid2)
    }

    func testMove() {
        let block = BlockC()
        
        block.position = Point(x: 3, y: 3)
        XCTAssertTrue(block.position == Point(x: 3, y: 3))
        block.moveDown()
        XCTAssertTrue(block.position == Point(x: 3, y: 4))
        block.moveLeft()
        XCTAssertTrue(block.position == Point(x: 2, y: 4))
        block.moveLeft()
        XCTAssertTrue(block.position == Point(x: 1, y: 4))
        block.moveDown()
        XCTAssertTrue(block.position == Point(x: 1, y: 5))
        block.moveRight()
        block.moveRight()
        XCTAssertTrue(block.position == Point(x: 3, y: 5))
    }
    
    func testDrop() {
        let block = BlockC()
        
        XCTAssert(block.isTimeToDrop() == false)
        XCTAssert(block.isTimeToDrop() == false)
        XCTAssert(block.isTimeToDrop() == false)
        XCTAssert(block.isTimeToDrop() == false)
        XCTAssert(block.isTimeToDrop() == false)
        XCTAssert(block.isTimeToDrop() == true)
        XCTAssert(block.isTimeToDrop() == false)
        XCTAssert(block.isTimeToDrop() == false)
        XCTAssert(block.isTimeToDrop() == false)
        XCTAssert(block.isTimeToDrop() == false)
        XCTAssert(block.isTimeToDrop() == false)
        XCTAssert(block.isTimeToDrop() == true)
    }

}
