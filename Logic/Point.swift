/*
 *  Point.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 7. 2..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


public struct Point {

    public var x: Int = 0
    public var y: Int = 0

}


extension Point {

    var leftPoint: Point {
        return Point(x: self.x - 1, y: self.y)
    }

    var rightPoint: Point {
        return Point(x: self.x + 1, y: self.y)
    }

    var underPoint: Point {
        return Point(x: self.x, y: self.y + 1)
    }

}


extension Point: Equatable {

}


public func == (lhs: Point, rhs: Point) -> Bool {
    return (lhs.x == rhs.x) && (lhs.y == rhs.y)
}


func + (left: Point, right: Point) -> Point {
    return Point(x: (left.x + right.x), y: (left.y + right.y))
}
