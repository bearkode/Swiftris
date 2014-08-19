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

    var leftPoint: Point {
        get {
            return Point(x: x - 1, y: y)
        }
    }
    
    var rightPoint: Point {
        get {
            return Point(x: x + 1, y: y)
        }
    }
    
    var downPoint: Point {
        get {
            return Point(x: x, y: y + 1)
        }
    }
    
    init () {
        
    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
}


func == (left: Point, right: Point) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}


func + (left: Point, right: Point) -> Point {
    return Point(x: (left.x + right.x), y: (left.y + right.y))
}
