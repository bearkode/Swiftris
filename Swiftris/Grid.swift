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
    
    let gridSize: GridSize
    
    var width: Int {
        get {
            return self.gridSize.width
        }
    }
    
    var height: Int {
        get {
            return self.gridSize.height
        }
    }
    
    private var buffer: [Int]
    
    init(width: Int, height: Int, array: [Int]) {
        self.gridSize = GridSize(width: width, height: height)
        self.buffer = Array(count: width * height, repeatedValue: 0)
        
        let count = array.count
        self.buffer[0..<count] = array[0..<count]
    }

    convenience init(width: Int, height: Int) {
        self.init(width: width, height: height, array: Array(count: width * height, repeatedValue:0))
    }
    
    func enumerateGrid(closure: (point:Point, value: Int, inout stop: Bool) -> Void) {
        enumerateGrid(gridSize.indexRange, closure: closure)
    }

    func enumerateRow(row: Int, closure: (point: Point, value: Int, inout stop: Bool) -> Void) {
        enumerateGrid(gridSize.rangeOfRow(row), closure: closure)
    }

    func enumerateGrid(range: Range<Int>, closure: (point: Point, value: Int, inout stop: Bool) -> Void) {
        var stop = false
        for var index = range.startIndex; index < range.endIndex && !stop; index++ {
            closure(point: gridSize.positionOfIndex(index), value: buffer[index], stop: &stop)
        }
    }
    
    func replaceRow(row: Int, array: [Int]) {
        assert(array.count == gridSize.width)
        buffer[gridSize.rangeOfRow(row)] = array[0..<array.count]
    }
    
    func isOverlappedGrid(grid: Grid, position: Point) -> Bool {
        var overlapped = false
        
        grid.enumerateGrid { (point: Point, value: Int, inout stop: Bool) in
            if value.exist && self.valueAtPosition(position + point).exist {
                (overlapped, stop) = (true, true)
            }
        }
        
        return overlapped
    }
    
    func valueAtPosition(position: Point) -> Int {
        return gridSize.validatePosition(position) ? self[position] : Int.max
    }
    
    func compactRowOver(row: Int) {
        for var y = row; y > 0; y-- {
            buffer[gridSize.rangeOfRow(y)] = buffer[gridSize.rangeOfRow(y - 1)]
        }
        replaceRow(0, array: Array(count: gridSize.width, repeatedValue:0))
    }
    
    func isFullRow(row: Int) -> Bool {
        for index in gridSize.rangeOfRow(row) where buffer[index].empty {
            return false
        }
        
        return true;
    }
    
    func copyGrid(grid: Grid, position: Point) {
        grid.enumerateGrid { (point: Point, value: Int, inout stop: Bool) in
            let gridPoint = point + position
            
            if gridPoint.y >= 0 && value.exist {
                self[gridPoint] = value
            }
        }
    }
    
    subscript(x: Int, y: Int) -> Int {
        get {
            return self[Point(x: x, y: y)]
        }
        set {
            self[Point(x: x, y: y)] = newValue
        }
    }
    
    subscript(position: Point) -> Int {
        get {
            assert(gridSize.validatePosition(position), "Index out of range")
            return buffer[gridSize.indexOfPosition(position)]
        }
        set {
            assert(gridSize.validatePosition(position), "Index out of range")
            buffer[gridSize.indexOfPosition(position)] = newValue
        }
    }

}
