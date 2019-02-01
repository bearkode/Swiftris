/*
 *  BoardTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 27..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import XCTest
@testable import Logic


class BoardTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testGridSize() {
        let board = Board(size: Size(width: 10, height: 12))

        XCTAssertTrue(board.gridSize.width == 10)
        XCTAssertTrue(board.gridSize.height == 12)
    }

    func testValue() {
        let board = Board(size: Size(width: 5, height: 5))
        let block = Block(type: .box)

        block.position = Point(x: 0, y: 0)

        board.immobilze(block: block)
        
        XCTAssertTrue(board.value(at: Point(x: 0, y: 0)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 1, y: 0)) == 1)
        XCTAssertTrue(board.value(at: Point(x: 2, y: 0)) == 1)
        XCTAssertTrue(board.value(at: Point(x: 3, y: 0)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 4, y: 0)) == 0)

        XCTAssertTrue(board.value(at: Point(x: 0, y: 1)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 1, y: 1)) == 1)
        XCTAssertTrue(board.value(at: Point(x: 2, y: 1)) == 1)
        XCTAssertTrue(board.value(at: Point(x: 3, y: 1)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 4, y: 1)) == 0)

        XCTAssertTrue(board.value(at: Point(x: 0, y: 2)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 1, y: 2)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 2, y: 2)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 3, y: 2)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 4, y: 2)) == 0)

        XCTAssertTrue(board.value(at: Point(x: 0, y: 3)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 1, y: 3)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 2, y: 3)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 3, y: 3)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 4, y: 3)) == 0)

        XCTAssertTrue(board.value(at: Point(x: 0, y: 4)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 1, y: 4)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 2, y: 4)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 3, y: 4)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 4, y: 4)) == 0)
    }

    func testIsPossiblePosition() {
        let board = Board(size: Size(width: 5, height: 5))
        let block = Block(type: .foldB)
        let other = Block(type: .bump)

        block.position = Point(x: 0, y: 2)
        board.immobilze(block: block)

        XCTAssertTrue(board.isPossible(at: Point(x: 2, y: 2), withBlock: other))
        XCTAssertFalse(board.isPossible(at: Point(x: 2, y: 1), withBlock: other))
        XCTAssertFalse(board.isPossible(at: Point(x: 3, y: 2), withBlock: other))
        XCTAssertTrue(board.isPossible(at: Point(x: 2, y: 3), withBlock: other))
    }

    func testIsOverlappedAtPosition() {
        let board = Board(size: Size(width: 30, height: 10))
        let block = Block(type: .box)

        block.position = Point(x: 0, y: 6)
        XCTAssertTrue(board.isOverlapped(with: block, at: block.position.underPoint) == false, "")
        block.position = Point(x: 0, y: 7)
        XCTAssertTrue(board.isOverlapped(with: block, at: block.position.underPoint) == false, "")
        block.position = Point(x: 0, y: 8)
        XCTAssertTrue(board.isOverlapped(with: block, at: block.position.underPoint) == true, "")
        block.position = Point(x: 0, y: 9)
        XCTAssertTrue(board.isOverlapped(with: block, at: block.position.underPoint) == true, "")
    }
    
    func testDeleteFullRow() {
        let board = Board(size: Size(width: 6, height: 4))
        var block: Block

        block = Block(type: .bump)
        block.position = Point(x: 0, y: 2)
        board.immobilze(block: block)
        block = Block(type: .bump)
        block.turn()
        block.position = Point(x: 2, y: 1)
        board.immobilze(block: block)
        block = Block(type: .foldB)
        block.turn()
        block.turn()
        block.position = Point(x: 3, y: 1)
        board.immobilze(block: block)

//        for var y = 0; y < 4; y++ {
//            var str = ""
//            for var x = 0; x < 6; x++ {
//                let value = board.valueAtPosition(Point(x: x, y: y))
//                str += "\(value)"
//            }
//            NSLog("\(str)")
//        }

        XCTAssertTrue(board.value(at: Point(x: 0, y: 0)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 1, y: 0)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 2, y: 0)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 3, y: 0)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 4, y: 0)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 5, y: 0)) == 0)

        XCTAssertTrue(board.value(at: Point(x: 0, y: 1)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 1, y: 1)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 2, y: 1)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 3, y: 1)) == 5)
        XCTAssertTrue(board.value(at: Point(x: 4, y: 1)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 5, y: 1)) == 4)

        XCTAssertTrue(board.value(at: Point(x: 0, y: 2)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 1, y: 2)) == 5)
        XCTAssertTrue(board.value(at: Point(x: 2, y: 2)) == 5)
        XCTAssertTrue(board.value(at: Point(x: 3, y: 2)) == 5)
        XCTAssertTrue(board.value(at: Point(x: 4, y: 2)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 5, y: 2)) == 4)

        XCTAssertTrue(board.value(at: Point(x: 0, y: 3)) == 5)
        XCTAssertTrue(board.value(at: Point(x: 1, y: 3)) == 5)
        XCTAssertTrue(board.value(at: Point(x: 2, y: 3)) == 5)
        XCTAssertTrue(board.value(at: Point(x: 3, y: 3)) == 5)
        XCTAssertTrue(board.value(at: Point(x: 4, y: 3)) == 4)
        XCTAssertTrue(board.value(at: Point(x: 5, y: 3)) == 4)

        board.deleteFullRow()

        XCTAssertTrue(board.value(at: Point(x: 0, y: 0)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 1, y: 0)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 2, y: 0)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 3, y: 0)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 4, y: 0)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 5, y: 0)) == 0)

        XCTAssertTrue(board.value(at: Point(x: 0, y: 1)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 1, y: 1)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 2, y: 1)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 3, y: 1)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 4, y: 1)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 5, y: 1)) == 0)

        XCTAssertTrue(board.value(at: Point(x: 0, y: 2)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 1, y: 2)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 2, y: 2)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 3, y: 2)) == 5)
        XCTAssertTrue(board.value(at: Point(x: 4, y: 2)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 5, y: 2)) == 4)

        XCTAssertTrue(board.value(at: Point(x: 0, y: 3)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 1, y: 3)) == 5)
        XCTAssertTrue(board.value(at: Point(x: 2, y: 3)) == 5)
        XCTAssertTrue(board.value(at: Point(x: 3, y: 3)) == 5)
        XCTAssertTrue(board.value(at: Point(x: 4, y: 3)) == 0)
        XCTAssertTrue(board.value(at: Point(x: 5, y: 3)) == 4)
    }

    func testDeleteFullRow2() {
        let board = Board(size: Size(width: 5, height: 5))
        board.grid.buffer = [ 0, 0, 0, 0, 0,
                              2, 2, 2, 2, 2,
                              1, 1, 0, 1, 0,
                              3, 3, 3, 3, 3,
                              4, 4, 0, 0, 4 ]
        board.deleteFullRow()
        XCTAssertTrue(board.grid.buffer == [ 0, 0, 0, 0, 0,
                                             0, 0, 0, 0, 0,
                                             0, 0, 0, 0, 0,
                                             1, 1, 0, 1, 0,
                                             4, 4, 0, 0, 4])
    }
}
