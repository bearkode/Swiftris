/*
 *  SizeTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 3..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import XCTest
@testable import Logic


class SizeTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInit() {
        let size = Size()
        XCTAssertTrue(size.width == 0)
        XCTAssertTrue(size.height == 0)
    }

    func testEnumerate() {
        let size = Size(width: 10, height: 10)
        var acc = 0
        size.enumerate { (position) -> () in
            acc += 1
        }
        XCTAssertTrue(acc == 100)
    }

    func testEqual() {
        XCTAssertTrue(Size(width: 10, height: 5) == Size(width: 10, height: 5))
        XCTAssertFalse(Size(width: 11, height: 10) == Size(width: 10, height: 10))
        XCTAssertFalse(Size(width: 10, height: 10) == Size(width: 10, height: 11))
        XCTAssertFalse(Size(width: 11, height: 11) == Size(width: 10, height: 10))
    }

}
