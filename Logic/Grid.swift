/*
 *  Grid.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 18..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


internal enum GridError: Error {

    case outOfBounds

}


internal class Grid<T: Equatable> {

    // MARK: - init

    internal init(size: Size, array: [T?]) {
        self.size = size
        self.buffer = Array(repeating: nil, count: size.extent)

        let count = array.count
        self.buffer[0..<count] = array[0..<count]
    }

    internal convenience init(size: Size) {
        self.init(size: size, array: Array(repeating: nil, count: size.extent))
    }

    // MARK: - internal

    internal let size: Size
    internal var buffer: [T?]

    internal func reset() {
        self.buffer = Array(repeating: nil, count: self.size.extent)
    }

    internal func replace(with array: [T?], forRow row: Int) {
        assert(array.count == self.size.width)
        self.buffer[self.size.range(of: row)] = array[0..<array.count]
    }

    internal func compress(rowOver row: Int) {
        stride(from: row, to: 0, by: -1).forEach {
            self.buffer[self.size.range(of: $0)] = self.slice(row: $0 - 1)
        }

        self.replace(with: Array(repeating: nil, count: self.size.width), forRow: 0)
    }

    internal func isFull(row: Int) -> Bool {
        return self.slice(row: row).filter { $0 == nil }.isEmpty
    }

    internal func slice(row: Int) -> ArraySlice<T?> {
        return self.buffer[self.size.range(of: row)]
    }

    internal var pointsHasValue: [Point] {
        return self.size.points.filter { self[$0] != nil }
    }

    // MARK: -

    internal func isOverlapped(withGrid grid: Grid, position: Point) -> Bool {
        let pointHasValue = grid.pointsHasValue.map { $0 + position }
        let validPoints = pointHasValue.filter { self.size.isValid(position: $0) }

        if pointHasValue.count != validPoints.count {
            return true
        }

        let canOverlap = pointHasValue.filter { self[$0] == nil }

        return pointHasValue.count != canOverlap.count
    }

    internal func value(atPosition position: Point) throws -> T? {
        guard self.size.isValid(position: position) else {
            throw GridError.outOfBounds
        }

        return self[position]
    }

    internal func copy(from grid: Grid, position: Point) {
        grid.pointsHasValue.forEach {
            if let value = grid[$0] {
                self[$0 + position] = value
            }
        }
    }

}


extension Grid: Equatable {

}


internal func == <T: Equatable>(lhs: Grid<T>, rhs: Grid<T>) -> Bool {
    return lhs.buffer == rhs.buffer
}
