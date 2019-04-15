//
//  curryTests.swift
//  LogicTests
//
//  Created by bearkode on 14/02/2019.
//  Copyright © 2019 bearkode. All rights reserved.
//

import XCTest
@testable import Logic


class curryTests: XCTestCase {

    override func setUp() {

    }

    override func tearDown() {

    }

    func testWith3Arguments() {
        func sample(a: Int, b: Int, c: Int) -> String {
            return "\(a)+\(b)+\(c)"
        }

        let curried = curry(sample)
        XCTAssertTrue(curried(1)(2)(3) == "1+2+3")
    }

    func testWith4Arguments() {
        func sample(a: Int, b: Int, c: Int, d: Int) -> String {
            return "\(a)+\(b)+\(c)+\(d)"
        }

        let curried = curry(sample)
        XCTAssertTrue(curried(1)(2)(3)(4) == "1+2+3+4")
    }

}
