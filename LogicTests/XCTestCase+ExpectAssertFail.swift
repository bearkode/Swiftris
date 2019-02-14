//
//  XCTestCase+ExpectAssertFail.swift
//  LogicTests
//
//  Created by bearkode on 14/02/2019.
//  Copyright © 2019 bearkode. All rights reserved.
//

import XCTest
@testable import Logic


extension XCTestCase {

    func expectAssertFail(expectedMessage: String, testcase: @escaping () -> Void) {
        let expectation = self.expectation(description: "expectingAssert")
        var assertionMessage: String? = nil

        assertClosure = { condition, message, _, _ in
            assertionMessage = message
            expectation.fulfill()
            self.unreachable()
        }

        DispatchQueue.global(qos: .userInitiated).async {
            testcase()
        }

        self.waitForExpectations(timeout: 2) { _ in
            XCTAssertTrue(assertionMessage == expectedMessage)
            assertClosure = defaultAssertClosure
        }
    }

    private func unreachable() -> Never {
        repeat {
            RunLoop.current.run()
        } while (true)
    }

}
