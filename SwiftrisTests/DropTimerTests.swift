/*
 *  DropTimerTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 3..
 *  Copyright © 2015년 bearkode. All rights reserved.
 *
 */

import XCTest


class DropTimerTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testBasic() {
        var timer = DropTimer()
        
        XCTAssert(timer.isTimeToDrop() == false)
        XCTAssert(timer.isTimeToDrop() == false)
        XCTAssert(timer.isTimeToDrop() == false)
        XCTAssert(timer.isTimeToDrop() == false)
        XCTAssert(timer.isTimeToDrop() == false)
        XCTAssert(timer.isTimeToDrop() == true)
        XCTAssert(timer.isTimeToDrop() == false)
        XCTAssert(timer.isTimeToDrop() == false)
        XCTAssert(timer.isTimeToDrop() == false)
        XCTAssert(timer.isTimeToDrop() == false)
        XCTAssert(timer.isTimeToDrop() == false)
        XCTAssert(timer.isTimeToDrop() == true)
    }

}
