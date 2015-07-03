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

    subscript(x: Int, y: Int) -> Int {
        get {
            return self[Point(x: x, y: y)]
        }
        set {
            self[Point(x: x, y: y)] = newValue
        }
    }
    
    subscript(position: Point) -> Int {
        get {
            assert(gridSize.validatePosition(position), "Index out of range")
            return buffer[gridSize.indexOfPosition(position)]
        }
        set {
            assert(gridSize.validatePosition(position), "Index out of range")
            buffer[gridSize.indexOfPosition(position)] = newValue
        }
    }

}