/*
 *  BlockTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 26..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import XCTest
@testable import Logic


class BlockTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreation() {
        var block: Block
        
        block = Block(type: .box)
        XCTAssertTrue(block.grids.count == 1)
        block = Block(type: .bar)
        XCTAssertTrue(block.grids.count == 2)
        block = Block(type: .foldA)
        XCTAssertTrue(block.grids.count == 4)
        block = Block(type: .foldB)
        XCTAssertTrue(block.grids.count == 4)
        block = Block(type: .bump)
        XCTAssertTrue(block.grids.count == 4)
        block = Block(type: .zigzagA)
        XCTAssertTrue(block.grids.count == 2)
        block = Block(type: .zigzagB)
        XCTAssertTrue(block.grids.count == 2)
    }

    func testContains() {
        let block = Block(type: .box)
        block.position = Point(x: 3, y: 3)

        XCTAssertFalse(block.contains(position: Point(x: 2, y: 2)), "")
        XCTAssertFalse(block.contains(position: Point(x: 2, y: 3)), "")
        XCTAssertFalse(block.contains(position: Point(x: 7, y: 2)), "")
        XCTAssertFalse(block.contains(position: Point(x: 7, y: 3)), "")
        XCTAssertFalse(block.contains(position: Point(x: 2, y: 7)), "")
        XCTAssertFalse(block.contains(position: Point(x: 3, y: 7)), "")
        XCTAssertFalse(block.contains(position: Point(x: 7, y: 7)), "")
        XCTAssertFalse(block.contains(position: Point(x: 6, y: 7)), "")
        XCTAssertFalse(block.contains(position: Point(x: 7, y: 6)), "")
    }
    
    func testBlockPositionInBlock()
    {
        let block = Block(type: .bump)
        block.position = Point(x: 10, y: 15)
        
        XCTAssertTrue((block.positionInBlock(from: Point(x: 10, y: 15)) == Point(x: 0, y: 0)), "")
        XCTAssertTrue((block.positionInBlock(from: Point(x: 10, y: 16)) == Point(x: 0, y: 1)), "")
        XCTAssertTrue((block.positionInBlock(from: Point(x: 13, y: 17)) == Point(x: 3, y: 2)), "")
    }
    
    func testValueAtPosition() {
        let block = Block(type: .box)
        block.position = Point(x: 5, y: 5)
        
        XCTAssertTrue(block.value(at: Point(x: 0, y: 4)) == 0, "")
        XCTAssertTrue(block.value(at: Point(x: 4, y: 4)) == 0, "")
        XCTAssertTrue(block.value(at: Point(x: 5, y: 5)) == 0, "")
        XCTAssertTrue(block.value(at: Point(x: 5, y: 6)) == 0, "")
        XCTAssertTrue(block.value(at: Point(x: 6, y: 5)) == 1, "")
        XCTAssertTrue(block.value(at: Point(x: 7, y: 5)) == 1, "")
        XCTAssertTrue(block.value(at: Point(x: 6, y: 6)) == 1, "")
        XCTAssertTrue(block.value(at: Point(x: 7, y: 6)) == 1, "")
        XCTAssertTrue(block.value(at: Point(x: 6, y: 7)) == 0, "")
        XCTAssertTrue(block.value(at: Point(x: 7, y: 7)) == 0, "")
        XCTAssertTrue(block.value(at: Point(x: 8, y: 5)) == 0, "")
        XCTAssertTrue(block.value(at: Point(x: 8, y: 6)) == 0, "")
        XCTAssertTrue(block.value(at: Point(x: 10, y: 10)) == 0, "")
    }

    let grid0 = Grid(size: GridSize(width: 4, height: 4), array: [0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 3, 0])
    let grid3 = Grid(size: GridSize(width: 4, height: 4), array: [3, 3, 3, 0, 3, 0, 0, 0])
    let grid2 = Grid(size: GridSize(width: 4, height: 4), array: [0, 3, 0, 0, 0, 3, 0, 0, 0, 3, 3, 0])
    let grid1 = Grid(size: GridSize(width: 4, height: 4), array: [0, 0, 3, 0, 3, 3, 3, 0])
    
    func testTurn() {
        let block = Block(type: .foldA)

        XCTAssertTrue(block.currentShape == grid0)
        block.turn()
        XCTAssertTrue(block.currentShape == grid3)
        block.turn()
        XCTAssertTrue(block.currentShape == grid2)
        block.turn()
        XCTAssertTrue(block.currentShape == grid1)
        block.turn()
        XCTAssertTrue(block.currentShape == grid0)
        block.turn()
        XCTAssertTrue(block.currentShape == grid3)
        block.turn()
        XCTAssertTrue(block.currentShape == grid2)
        block.turn()
        XCTAssertTrue(block.currentShape == grid1)
        block.turn()
        XCTAssertTrue(block.currentShape == grid0)
    }
    
    func testNextGrid() {
        let block = Block(type: .foldA)

        XCTAssertTrue(block.currentShape == grid0)
        XCTAssertTrue(block.nextShape == grid3)
        
        block.turn()
        XCTAssertTrue(block.currentShape == grid3)
        XCTAssertTrue(block.nextShape == grid2)
        
        block.turn()
        XCTAssertTrue(block.currentShape == grid2)
        XCTAssertTrue(block.nextShape == grid1)

        block.turn()
        XCTAssertTrue(block.currentShape == grid1)
        XCTAssertTrue(block.nextShape == grid0)

        block.turn()
        XCTAssertTrue(block.currentShape == grid0)
        XCTAssertTrue(block.nextShape == grid3)
        
        block.turn()
        XCTAssertTrue(block.currentShape == grid3)
        XCTAssertTrue(block.nextShape == grid2)
    }

    func testMove() {
        let block = Block(type: .foldA)
        
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
        let block = Block(type: .foldA)
        
        XCTAssert(block.timeToDrop == false)
        XCTAssert(block.timeToDrop == false)
        XCTAssert(block.timeToDrop == false)
        XCTAssert(block.timeToDrop == false)
        XCTAssert(block.timeToDrop == false)
        XCTAssert(block.timeToDrop == true)
        XCTAssert(block.timeToDrop == false)
        XCTAssert(block.timeToDrop == false)
        XCTAssert(block.timeToDrop == false)
        XCTAssert(block.timeToDrop == false)
        XCTAssert(block.timeToDrop == false)
        XCTAssert(block.timeToDrop == true)
    }

}
