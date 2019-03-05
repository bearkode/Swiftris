/*
 *  BlockGeneratorTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2016. 7. 28..
 *  Copyright © 2016 bearkode. All rights reserved.
 *
 */

import XCTest
@testable import Logic


class BlockGeneratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testBasic() {
        var remainCases = Set<BlockType>(BlockType.allCases)
        var nextBlock = BlockGenerator.sharedGenerator.nextBlock
        
        XCTAssertTrue(remainCases.count == 7)
        
        while remainCases.count != 0 {
            let block = BlockGenerator.sharedGenerator.block(withPosition: Point(x: 3, y: 0))

            XCTAssertTrue(block.type == nextBlock.type)
            XCTAssertTrue(block.position == Point(x: 3, y: 0))
            
            remainCases.remove(block.type)
            nextBlock = BlockGenerator.sharedGenerator.nextBlock
        }
    }

}
