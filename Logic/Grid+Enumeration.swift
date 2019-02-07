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

    internal func enumerate(_ closure: (_: Point, _: T?, _: inout Bool) throws -> Void) rethrows {
        try self.enumerate(inRange: self.size.indexRange, closure: closure)
    }

    internal func enumerate(inRow row: Int, closure: (_: Point, _: T?, _: inout Bool) throws -> Void) rethrows {
        try self.enumerate(inRange: self.size.range(of: row), closure: closure)
    }

    internal func enumerate(inRange range: Range<Int>, closure: (_: Point, _: T?, _: inout Bool) throws -> Void) rethrows {
        var stop = false

        for index in range {
            try closure(self.size.point(of: index), self.buffer[index], &stop)
            if stop {
                break
            }
        }
    }

    internal func enumerateRowsFromTop(_ closure: (_: Int) -> Void) {
        stride(from: (self.size.height - 1), through: 0, by: -1).forEach(closure)
    }

}
