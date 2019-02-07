/*
 *  Grid+Enumeration.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 3..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import Foundation


extension Grid {

    internal func enumerate(inRow row: Int, closure: (_: Point, _: T?) throws -> Void) rethrows {
        try self.enumerate(inRange: self.size.range(of: row), closure: closure)
    }

    internal func enumerate(inRange range: Range<Int>, closure: (_: Point, _: T?) throws -> Void) rethrows {
        try range.forEach {
            try closure(self.size.point(of: $0), self.buffer[$0])
        }
    }

    internal func enumerateRowsFromTop(_ closure: (_: Int) -> Void) {
        stride(from: (self.size.height - 1), through: 0, by: -1).forEach(closure)
    }

}
