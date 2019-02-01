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
        self.indexRange = 0..<(width * height)
    }

    public init () {
        self.init(width: 0, height: 0)
    }

    // MARK: - public

    public let width: Int
    public let height: Int
    public var extent: Int {
        return width * height
    }

    public func enumerate(_ closure: (_: Point) -> Void) {
        self.indexRange.map { self.point(of: $0) }
                       .forEach { closure($0) }
    }

    // MARK: - inernal

    internal let indexRange: Range<Int>

}


extension Size {

    internal func isValid(position: Point) -> Bool {
        return position.x >= 0 && position.x < self.width && position.y >= 0 && position.y < self.height
    }

    internal func index(of position: Point) -> Int {
        return position.y * self.width + position.x
    }

    internal func point(of index: Int) -> Point {
        return Point(x: index % self.width, y: index / self.width)
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
