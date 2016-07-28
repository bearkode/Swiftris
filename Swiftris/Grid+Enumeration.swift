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

    func enumerateGrid(_ closure: (point:Point, value: Int, inout stop: Bool) -> Void) {
        self.enumerateGrid(self.size.indexRange, closure: closure)
    }
    
    func enumerateRow(_ row: Int, closure: (point: Point, value: Int, inout stop: Bool) -> Void) {
        self.enumerateGrid(self.size.rangeOfRow(row), closure: closure)
    }
    
    func enumerateGrid(_ range: CountableRange<Int>, closure: (point: Point, value: Int, inout stop: Bool) -> Void) {
        var stop = false

        for index in range {
            closure(point: self.size.positionOfIndex(index), value: self.buffer[index], stop: &stop)
            if stop {
                break;
            }
        }
        
    }

}
