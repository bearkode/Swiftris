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
        XCTAssertTrue(BlockType.allCases.count == 7)
    }

    func testRandomType() {
        let allCases = BlockType.allCases
        var remainTypes = Set<BlockType>(allCases)

        XCTAssertTrue(remainTypes.count == 7)

        for _ in 0..<1000 {
            let type = BlockType.makeRandomType()

            XCTAssertTrue(allCases.contains(type))
            remainTypes.remove(type)

            if remainTypes.count == 0 {
                break
            }
        }
    }

    func testMakeBlockType() {
        XCTAssertTrue(BlockType.makeBlockType(with: 0) == .box)
        XCTAssertTrue(BlockType.makeBlockType(with: 1) == .bar)
        XCTAssertTrue(BlockType.makeBlockType(with: 2) == .foldA)
        XCTAssertTrue(BlockType.makeBlockType(with: 3) == .foldB)
        XCTAssertTrue(BlockType.makeBlockType(with: 4) == .bump)
        XCTAssertTrue(BlockType.makeBlockType(with: 5) == .zigzagA)
        XCTAssertTrue(BlockType.makeBlockType(with: 6) == .zigzagB)
        XCTAssertTrue(BlockType.makeBlockType(with: 7) == .bar)
        XCTAssertTrue(BlockType.makeBlockType(with: -1) == .bar)
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
