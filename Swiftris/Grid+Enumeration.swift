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

    func enumerate(_ closure: (point:Point, value: Int, inout stop: Bool) -> Void) {
        self.enumerate(inRange: self.size.indexRange, closure: closure)
    }
    
    func enumerate(inRow row: Int, closure: (point: Point, value: Int, inout stop: Bool) -> Void) {
        self.enumerate(inRange: self.size.range(ofRow: row), closure: closure)
    }
    
    func enumerate(inRange range: CountableRange<Int>, closure: (point: Point, value: Int, inout stop: Bool) -> Void) {
        var stop = false

        for index in range {
            closure(point: self.size.position(ofIndex: index), value: self.buffer[index], stop: &stop)
            if stop {
                break;
            }
        }
        
    }

}
