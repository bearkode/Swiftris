/*
 *  NSColorExtensionTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2016. 7. 29..
 *  Copyright © 2016 bearkode. All rights reserved.
 *
 */

import XCTest
@testable import Logic


class NSColorExtensionTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testColorForIndex() {
        var color = NSColor.color(forIndex: 0)
        XCTAssertTrue(color.redComponent == 0.7)
        XCTAssertTrue(color.greenComponent == 0.7)
        XCTAssertTrue(color.blueComponent == 0.7)
        XCTAssertTrue(color.alphaComponent == 1.0)

        color = NSColor.color(forIndex: 7)
        XCTAssertTrue(color.redComponent == 0.5)
        XCTAssertTrue(color.greenComponent == 1.0)
        XCTAssertTrue(color.blueComponent == 1.0)
        XCTAssertTrue(color.alphaComponent == 1.0)
        
        color = NSColor.color(forIndex: 8)
        XCTAssertTrue(color.redComponent == 1.0)
        XCTAssertTrue(color.greenComponent == 1.0)
        XCTAssertTrue(color.blueComponent == 1.0)
        XCTAssertTrue(color.alphaComponent == 1.0)
    }
    
    func testHalftone() {
        let color = NSColor(calibratedRed: 0.8, green: 1.0, blue: 0.5, alpha: 1.0).halftone()
        XCTAssertTrue(color.redComponent == 0.4)
        XCTAssertTrue(color.greenComponent == 0.5)
        XCTAssertTrue(color.blueComponent == 0.25)
        XCTAssertTrue(color.alphaComponent == 1.0)
    }

}
