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
    
    var buffer: [Int]
    
    init(width: Int, height: Int, array: [Int]) {
        self.gridSize = GridSize(width: width, height: height)
        self.buffer = Array(count: width * height, repeatedValue: 0)
        
        let count = array.count
        self.buffer[0..<count] = array[0..<count]
    }

    convenience init(width: Int, height: Int) {
        self.init(width: width, height: height, array: Array(count: width * height, repeatedValue:0))
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
