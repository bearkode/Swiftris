/*
 *  IntExtensionTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 3..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import XCTest
@testable import Logic


class IntExtensionTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testZero() {
        let zero = 0
        XCTAssert(zero.isEmpty == true)
        XCTAssert(zero.isExist == false)
    }

    func testNonZero() {
        let nonZero = 10
        XCTAssert(nonZero.isEmpty == false)
        XCTAssert(nonZero.isExist == true)
    }

}
