//
//  assert.swift
//  Logic
//
//  Created by bearkode on 14/02/2019.
//  Copyright © 2019 bearkode. All rights reserved.
//

import Foundation


internal func assert(_ condition: @autoclosure () -> Bool,
                     _ message: @autoclosure () -> String = "",
                     file: StaticString = #file,
                     line: UInt = #line) {
    assertClosure(condition(), message(), file, line)
}

internal var assertClosure: (Bool, String, StaticString, UInt) -> Void = defaultAssertClosure
internal let defaultAssertClosure = { Swift.assert($0, $1, file: $2, line: $3) }
