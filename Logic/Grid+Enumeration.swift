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

    func enumerate(_ closure: (_: Point, _: Int, _: inout Bool) -> Void) {
        self.enumerate(inRange: self.size.indexRange, closure: closure)
    }

    func enumerate(inRow row: Int, closure: (_: Point, _: Int, _: inout Bool) -> Void) {
        self.enumerate(inRange: self.size.range(ofRow: row), closure: closure)
    }

    func enumerate(inRange range: CountableRange<Int>, closure: (_: Point, _: Int, _: inout Bool) -> Void) {
        var stop = false

        for index in range {
            closure(self.size.position(ofIndex: index), self.buffer[index], &stop)
            if stop {
                break
            }
        }
    }

    func enumerateRowsFromTop(_ closure: (_: Int) -> Void) {
        for row in stride(from: (self.size.height - 1), through: 0, by: -1) {
            closure(row)
        }
    }

}
