/*
 *  IntExtensionTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 3..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import XCTest


class IntExtensionTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testZero() {
        let zero = 0
        XCTAssert(zero.empty == true)
        XCTAssert(zero.exist == false)
    }

    func testNonZero() {
        let nonZero = 10
        XCTAssert(nonZero.empty == false)
        XCTAssert(nonZero.exist == true)
    }

}
