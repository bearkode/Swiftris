/*
 *  Size.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 7. 2..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


public struct Size {

    // MARK: - init

    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.extent = SizeHelper.extent(width: width, height: height)
        self.indexRange = SizeHelper.indexRange(width: width, height: height)
        self.points = SizeHelper.points(width: width, height: height)
    }

    public init () {
        self.init(width: 0, height: 0)
    }

    // MARK: - public

    public let width: Int
    public let height: Int
    public let extent: Int
    public let points: Set<Point>

    // MARK: - inernal

    internal let indexRange: Range<Int>

}


extension Size {

    internal func validate(position: Point) -> Bool {
        return self.points.contains(position)
    }

    internal func isValid(_ set: Set<Point>) -> Bool {
        return self.points.isSuperset(of: set)
    }

    internal func index(of position: Point) -> Int {
        return position.y * self.width + position.x
    }

    internal func point(of index: Int) -> Point {
        return SizeHelper.point(width: self.width, index: index)
    }

    internal func range(of row: Int) -> Range<Int> {
        return (row * self.width)..<((row * self.width) + self.width)
    }

}


extension Size: Equatable {

}


public func == (lhs: Size, rhs: Size) -> Bool {
    return (lhs.width == rhs.width) && (lhs.height == rhs.height)
}


internal enum SizeHelper {

    internal static func extent(width: Int, height: Int) -> Int {
        return width * height
    }

    internal static func points(width: Int, height: Int) -> Set<Point> {
        let point = curry(SizeHelper.point)(width)
        return Set(SizeHelper.indexRange(width: width, height: height).map(point))
    }

    internal static func point(width: Int, index: Int) -> Point {
        return Point(x: index % width, y: index / width)
    }

    internal static func indexRange(width: Int, height: Int) -> Range<Int> {
        return 0..<(self.extent(width: width, height: height))
    }

}
