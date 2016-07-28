/*
 *  BlockGeneratorTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2016. 7. 28..
 *  Copyright © 2016 bearkode. All rights reserved.
 *
 */

import XCTest


class BlockGeneratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testBasic() {
        let allTypes = BlockType.allTypes
        var remainTypes = allTypes
        var nextBlock = BlockGenerator.sharedGenerator.nextBlock
        
        XCTAssertTrue(remainTypes.count == 7)
        
        while remainTypes.count != 0 {
            let block = BlockGenerator.sharedGenerator.block(withPosition: Point(x: 3, y: 0))

            XCTAssertTrue(block.type == nextBlock.type)
            XCTAssertTrue(block.position == Point(x: 3, y: 0))
            
            remainTypes.remove(block.type)
            nextBlock = BlockGenerator.sharedGenerator.nextBlock
        }
    }

}
