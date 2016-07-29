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

    func enumerate(_ closure: (point:Point, value: Int, stop: inout Bool) -> Void) {
        self.enumerate(inRange: self.size.indexRange, closure: closure)
    }
    
    func enumerate(inRow row: Int, closure: (point: Point, value: Int, stop: inout Bool) -> Void) {
        self.enumerate(inRange: self.size.range(ofRow: row), closure: closure)
    }
    
    func enumerate(inRange range: CountableRange<Int>, closure: (point: Point, value: Int, stop: inout Bool) -> Void) {
        var stop = false

        for index in range {
            closure(point: self.size.position(ofIndex: index), value: self.buffer[index], stop: &stop)
            if stop {
                break;
            }
        }
    }
    
    func enumerateRowsFromTop(_ closure: (row: Int) -> Void) {
        for row in stride(from: (self.size.height - 1), through: 0, by: -1) {
            closure(row: row)
        }
    }

}
