/*
 *  MovementTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 3..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import XCTest

class MovementTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testBasic() {
        let movement = Movement(position: Point(x: 10, y: 10), shapeCount: 4)
        
        XCTAssertTrue(movement.position == Point(x: 10, y: 10))
        XCTAssertTrue(movement.rotateIndex == 0)
        
        movement.left()
        XCTAssertTrue(movement.position == Point(x: 9, y: 10))
        movement.down()
        XCTAssertTrue(movement.position == Point(x: 9, y: 11))
        movement.right()
        XCTAssertTrue(movement.position == Point(x: 10, y: 11))
        
        movement.turn()
        XCTAssertTrue(movement.rotateIndex == 3)
        movement.turn()
        XCTAssertTrue(movement.rotateIndex == 2)
        movement.turn()
        XCTAssertTrue(movement.rotateIndex == 1)
        movement.turn()
        XCTAssertTrue(movement.rotateIndex == 0)
        movement.turn()
        XCTAssertTrue(movement.rotateIndex == 3)
        movement.turn()
        XCTAssertTrue(movement.rotateIndex == 2)
        movement.turn()
        XCTAssertTrue(movement.rotateIndex == 1)
        movement.turn()
        XCTAssertTrue(movement.rotateIndex == 0)
        
        XCTAssert(movement.isTimeToDrop() == false)
        XCTAssert(movement.isTimeToDrop() == false)
        XCTAssert(movement.isTimeToDrop() == false)
        XCTAssert(movement.isTimeToDrop() == false)
        XCTAssert(movement.isTimeToDrop() == false)
        XCTAssert(movement.isTimeToDrop() == true)
        XCTAssert(movement.isTimeToDrop() == false)
        XCTAssert(movement.isTimeToDrop() == false)
        XCTAssert(movement.isTimeToDrop() == false)
        XCTAssert(movement.isTimeToDrop() == false)
        XCTAssert(movement.isTimeToDrop() == false)
        XCTAssert(movement.isTimeToDrop() == true)
    }
    
    func test2Shape() {
        let movement = Movement(position: Point(x: 10, y: 10), shapeCount: 2)
        
        movement.turn()
        XCTAssertTrue(movement.rotateIndex == 1)
        movement.turn()
        XCTAssertTrue(movement.rotateIndex == 0)
        movement.turn()
        XCTAssertTrue(movement.rotateIndex == 1)
        movement.turn()
        XCTAssertTrue(movement.rotateIndex == 0)
        movement.turn()
    }

}
