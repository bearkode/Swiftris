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
        size.points.forEach { (position) -> () in
            acc += 1
        }
        XCTAssertTrue(acc == 100)
    }

    func testPointOfIndex() {
        let size = Size(width: 3, height: 3)

        XCTAssertTrue(size.point(of: 0) ==  Point(x: 0, y: 0))
        XCTAssertTrue(size.point(of: 1) ==  Point(x: 1, y: 0))
        XCTAssertTrue(size.point(of: 2) ==  Point(x: 2, y: 0))
        XCTAssertTrue(size.point(of: 3) ==  Point(x: 0, y: 1))
        XCTAssertTrue(size.point(of: 4) ==  Point(x: 1, y: 1))
        XCTAssertTrue(size.point(of: 5) ==  Point(x: 2, y: 1))
        XCTAssertTrue(size.point(of: 6) ==  Point(x: 0, y: 2))
        XCTAssertTrue(size.point(of: 7) ==  Point(x: 1, y: 2))
        XCTAssertTrue(size.point(of: 8) ==  Point(x: 2, y: 2))
        self.expectAssertFail(expectedMessage: "Index out of range") {
            _ = size.point(of: 9)
        }
    }

    func testEqual() {
        XCTAssertTrue(Size(width: 10, height: 5) == Size(width: 10, height: 5))
        XCTAssertFalse(Size(width: 11, height: 10) == Size(width: 10, height: 10))
        XCTAssertFalse(Size(width: 10, height: 10) == Size(width: 10, height: 11))
        XCTAssertFalse(Size(width: 11, height: 11) == Size(width: 10, height: 10))
    }

}
