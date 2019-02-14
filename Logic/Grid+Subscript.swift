/*
 *  Grid+Subscript.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 3..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import Foundation


extension Grid {

    internal subscript(x: Int, y: Int) -> T? {
        get {
            return self[Point(x: x, y: y)]
        }
        set {
            self[Point(x: x, y: y)] = newValue
        }
    }

    internal subscript(position: Point) -> T? {
        get {
            assert(self.size.validate(position: position), "Index out of range")
            return buffer[self.size.index(of: position)]
        }
        set {
            assert(self.size.validate(position: position), "Index out of range")
            buffer[self.size.index(of: position)] = newValue
        }
    }

}
