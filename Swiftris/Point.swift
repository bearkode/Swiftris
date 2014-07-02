/*
 *  Point.swift
 *  Swiftris
 *
 *  Created by cgkim on 2014. 7. 2..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


struct Point {
    
    var x: Int = 0
    var y: Int = 0
    
    init () {
        
    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
}


@infix func == (left: Point, right: Point) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}


@infix func + (left: Point, right: Point) -> Point {
    return Point(x: (left.x + right.x), y: (left.y + right.y))
}
