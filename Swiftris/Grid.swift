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
    func replaceRow(_ row: Int, array: [Int]) {
        assert(array.count == self.size.width)
        self.buffer[self.size.rangeOfRow(row)] = array[0..<array.count]
    }

    func compactRowOver(_ row: Int) {
        for y in stride(from: row, to: 0, by: -1) {
            self.buffer[size.rangeOfRow(y)] = self.buffer[self.size.rangeOfRow(y - 1)]
        }
        
        self.replaceRow(0, array: Array(repeating: 0, count: self.size.width))
    }
    
    func isFullRow(_ row: Int) -> Bool {
        for index in self.size.rangeOfRow(row) where self.buffer[index].empty {
            return false
        }
        
        return true;
    }

    //  MARK: -
    func isOverlappedGrid(_ grid: Grid, position: Point) -> Bool {
        var overlapped = false
        
        grid.enumerateGrid { (point: Point, value: Int, stop: inout Bool) in
            if value.exist && self.valueAtPosition(position + point).exist {
                (overlapped, stop) = (true, true)
            }
        }
        
        return overlapped
    }
    
    func valueAtPosition(_ position: Point) -> Int {
        return self.size.validatePosition(position) ? self[position] : Int.max
    }
    
    func copyGrid(_ grid: Grid, position: Point) {
        grid.enumerateGrid { (point: Point, value: Int, stop: inout Bool) in
            let gridPoint = point + position
            
            if gridPoint.y >= 0 && value.exist {
                self[gridPoint] = value
            }
        }
    }

}


func == (left: Grid, right: Grid) -> Bool {
    var result = true
    
    left.enumerateGrid { (point, value, stop) -> Void in
        if right.valueAtPosition(point) != value {
            stop = true
            result = false
        }
    }

    return result
}
