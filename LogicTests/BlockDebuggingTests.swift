/*
 *  BlockDebuggingTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2016. 7. 29..
 *  Copyright © 2016 bearkode. All rights reserved.
 *
 */

import XCTest
@testable import Logic


class BlockDebuggingTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testBasic() {
        let block = Block(type: .foldA, position: Point(x: 10, y: 30))
        XCTAssertTrue(block.description == "Block type: foldA at: 10, 30")
    }

    func testDebugPrint() {
        let block = Block(type: .box, position: Point(x: 10, y: 10))
        block.debugPrint()
    }

}
