/*
 *  PointTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 3..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import XCTest


class PointTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEqual() {
        XCTAssertTrue(Point(x: 10, y: 10) == Point(x: 10, y: 10))
        XCTAssertFalse(Point(x: 10, y: 10) == Point(x: 10, y: 11))
        XCTAssertFalse(Point(x: 11, y: 10) == Point(x: 10, y: 10))
        XCTAssertFalse(Point(x: 11, y: 10) == Point(x: 10, y: 11))
    }
    
    func testBasic() {
        let point = Point(x: 10, y: 10)
        
        XCTAssertTrue(point.leftPoint == Point(x: 9, y: 10))
        XCTAssertTrue(point.rightPoint == Point(x: 11, y: 10))
        XCTAssertTrue(point.underPoint == Point(x: 10, y: 11))
    }

}
