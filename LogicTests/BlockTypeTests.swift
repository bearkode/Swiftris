/*
 *  BlockTypeTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2016. 7. 28..
 *  Copyright © 2016 bearkode. All rights reserved.
 *
 */

import XCTest
@testable import Logic


class BlockTypeTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testAllBlocks() {
        XCTAssertTrue(BlockType.allTypes.count == 7)
    }

    func testRandomType() {
        let allTypes = BlockType.allTypes
        var remainTypes = allTypes

        XCTAssertTrue(remainTypes.count == 7)

        for _ in 0..<1000 {
            let type = BlockType.randomType

            XCTAssertTrue(allTypes.contains(type))
            remainTypes.remove(type)

            if remainTypes.count == 0 {
                break
            }
        }
    }

    func testGrids() {
        XCTAssertTrue(BlockType.box.grids.count == 1)
        XCTAssertTrue(BlockType.bar.grids.count == 2)
        XCTAssertTrue(BlockType.foldA.grids.count == 4)
        XCTAssertTrue(BlockType.foldB.grids.count == 4)
        XCTAssertTrue(BlockType.bump.grids.count == 4)
        XCTAssertTrue(BlockType.zigzagA.grids.count == 2)
        XCTAssertTrue(BlockType.zigzagB.grids.count == 2)
    }

}
