//
//  RowTests.swift
//  LogicTests
//
//  Created by bearkode on 08/02/2019.
//  Copyright © 2019 bearkode. All rights reserved.
//

import XCTest
@testable import Logic


class RowTests: XCTestCase {

    override func setUp() {

    }

    override func tearDown() {

    }

    func testBasic() {
        let row1 = Row<Int>(index: 3, buffer: [1, 2, 3, 4, 5])
        XCTAssertTrue(row1.isFull)
        XCTAssertFalse(row1.isEmpty)

        let row2 = Row<Int>(index: 3, buffer: [nil, nil, nil])
        XCTAssertFalse(row2.isFull)
        XCTAssertTrue(row2.isEmpty)

        let row3 = Row<Int>(index: 3, buffer: [nil, 2, nil])
        XCTAssertFalse(row3.isFull)
        XCTAssertFalse(row3.isEmpty)

        let row4 = Row<Int>(index: 3, buffer: [nil, 2, 3])
        XCTAssertFalse(row4.isFull)
        XCTAssertFalse(row4.isEmpty)

        let row5 = Row<Int>(index: 3, buffer: [1, nil, 3])
        XCTAssertFalse(row5.isFull)
        XCTAssertFalse(row5.isEmpty)
    }

}
