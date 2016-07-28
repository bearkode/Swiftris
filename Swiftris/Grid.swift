/*
 *  Grid.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 18..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class Grid {
    
    let size: GridSize
    var buffer: [Int]

    //  MARK: -
    init(width: Int, height: Int, array: [Int]) {
        self.size = GridSize(width: width, height: height)
        self.buffer = Array(repeating: 0, count: width * height)
        
        let count = array.count
        self.buffer[0..<count] = array[0..<count]
    }

    convenience init(width: Int, height: Int) {
        self.init(width: width, height: height, array: Array(repeating: 0, count: width * height))
    }
    
    //  MARK: -
    func replace(with array: [Int], forRow row: Int) {
        assert(array.count == self.size.width)
        self.buffer[self.size.range(ofRow: row)] = array[0..<array.count]
    }

    func compress(rowOver row: Int) {
        for y in stride(from: row, to: 0, by: -1) {
            self.buffer[size.range(ofRow: y)] = self.buffer[self.size.range(ofRow: y - 1)]
        }
        
        self.replace(with: Array(repeating: 0, count: self.size.width), forRow: 0)
    }
    
    func isFull(row: Int) -> Bool {
        for index in self.size.range(ofRow: row) where self.buffer[index].isEmpty {
            return false
        }
        
        return true;
    }

    //  MARK: -
    func isOverlapped(withGrid grid: Grid, position: Point) -> Bool {
        var overlapped = false
        
        grid.enumerate { (point: Point, value: Int, stop: inout Bool) in
            if value.isExist && self.value(at: position + point).isExist {
                (overlapped, stop) = (true, true)
            }
        }
        
        return overlapped
    }
    
    func value(at position: Point) -> Int {
        return self.size.isValidPosition(position) ? self[position] : Int.max
    }
    
    func copy(from grid: Grid, position: Point) {
        grid.enumerate { (point: Point, value: Int, stop: inout Bool) in
            let gridPoint = point + position
            
            if gridPoint.y >= 0 && value.isExist {
                self[gridPoint] = value
            }
        }
    }

}


func == (left: Grid, right: Grid) -> Bool {
    var result = true
    
    left.enumerate { (point, value, stop) -> Void in
        if right.value(at: point) != value {
            stop = true
            result = false
        }
    }

    return result
}
