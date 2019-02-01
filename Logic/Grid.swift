/*
 *  Grid.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 18..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


internal class Grid {

    // MARK: - init

    internal init(size: Size, array: [Int]) {
        self.size = size
        self.buffer = Array(repeating: 0, count: size.extent)

        let count = array.count
        self.buffer[0..<count] = array[0..<count]
    }

    internal convenience init(size: Size) {
        self.init(size: size, array: Array(repeating: 0, count: size.extent))
    }

    // MARK: - internal

    internal let size: Size
    internal var buffer: [Int]

    internal func reset() {
        self.buffer = Array(repeating: 0, count: self.size.extent)
    }

    internal func replace(with array: [Int], forRow row: Int) {
        assert(array.count == self.size.width)
        self.buffer[self.size.range(ofRow: row)] = array[0..<array.count]
    }

    internal func compress(rowOver row: Int) {
        stride(from: row, to: 0, by: -1).forEach {
            self.buffer[self.size.range(ofRow: $0)] = self.slice(row: $0 - 1)
        }

        self.replace(with: Array(repeating: 0, count: self.size.width), forRow: 0)
    }

    internal func isFull(row: Int) -> Bool {
        return self.slice(row: row).filter { $0.isEmpty }.isEmpty
    }

    internal func slice(row: Int) -> ArraySlice<Int> {
        return self.buffer[self.size.range(ofRow: row)]
    }

    // MARK: -

    internal func isOverlapped(withGrid grid: Grid, position: Point) -> Bool {
        var overlapped = false

        grid.enumerate { (point: Point, value: Int, stop: inout Bool) in
            if value.isExist && self.value(atPosition: position + point).isExist {
                (overlapped, stop) = (true, true)
            }
        }

        return overlapped
    }

    internal func value(atPosition position: Point) -> Int {
        return self.size.isValid(position: position) ? self[position] : Int.max
    }

    internal func copy(from grid: Grid, position: Point) {
        grid.enumerate { (point: Point, value: Int, _: inout Bool) in
            let gridPoint = point + position

            if gridPoint.y >= 0 && value.isExist {
                self[gridPoint] = value
            }
        }
    }

}


extension Grid: Equatable {

}


internal func == (lhs: Grid, rhs: Grid) -> Bool {
    return lhs.buffer == rhs.buffer
}
