/*
 *  Grid.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 18..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


internal class Grid<T: Equatable> {

    // MARK: - init

    internal init(size: Size, array: [T], defaultValue: T) {
        self.size = size
        self.defaultValue = defaultValue
        self.buffer = Array(repeating: self.defaultValue, count: size.extent)

        let count = array.count
        self.buffer[0..<count] = array[0..<count]
    }

    internal convenience init(size: Size, defaultValue: T) {
        self.init(size: size, array: Array(repeating: defaultValue, count: size.extent), defaultValue: defaultValue)
    }

    // MARK: - internal

    internal let size: Size
    internal let defaultValue: T
    internal var buffer: [T]

    internal func reset() {
        self.buffer = Array(repeating: self.defaultValue, count: self.size.extent)
    }

    internal func replace(with array: [T], forRow row: Int) {
        assert(array.count == self.size.width)
        self.buffer[self.size.range(ofRow: row)] = array[0..<array.count]
    }

    internal func compress(rowOver row: Int) {
        stride(from: row, to: 0, by: -1).forEach {
            self.buffer[self.size.range(ofRow: $0)] = self.slice(row: $0 - 1)
        }

        self.replace(with: Array(repeating: self.defaultValue, count: self.size.width), forRow: 0)
    }

    internal func isFull(row: Int) -> Bool {
        return self.slice(row: row).filter { $0 == self.defaultValue }.isEmpty
    }

    internal func slice(row: Int) -> ArraySlice<T> {
        return self.buffer[self.size.range(ofRow: row)]
    }

    // MARK: -

    internal func isOverlapped(withGrid grid: Grid, position: Point) -> Bool {
        var overlapped = false

        grid.enumerate { (point: Point, value: T, stop: inout Bool) in
            if value != self.defaultValue && self.value(atPosition: position + point) != self.defaultValue {
                (overlapped, stop) = (true, true)
            }
        }

        return overlapped
    }

    internal func value(atPosition position: Point) -> T? {
        return self.size.isValid(position: position) ? self[position] : nil
    }

    internal func copy(from grid: Grid, position: Point) {
        grid.enumerate { (point: Point, value: T, _: inout Bool) in
            let gridPoint = point + position

            if gridPoint.y >= 0 && value != self.defaultValue {
                self[gridPoint] = value
            }
        }
    }

}


extension Grid: Equatable {

}


internal func == <T: Equatable>(lhs: Grid<T>, rhs: Grid<T>) -> Bool {
    return lhs.buffer == rhs.buffer
}
