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
    var buffer: Int[]
    
    init(width: Int, height: Int, array: Int[]) {
        self.gridSize = GridSize(width: width, height: height)
        self.buffer = Array(count: width * height, repeatedValue: 0)
        
        let count = array.count
        buffer[0..count] = array[0..count]
    }

    convenience init(width: Int, height: Int) {
        self.init(width: width, height: height, array: [])
    }
    
    func enumerateGrid(closure: (point:Point, value: Int, inout stop: Bool) -> ()) {
        enumerateGrid(gridSize.indexRange, closure)
    }
    
    func enumerateGrid(range: Range<Int>, closure: (point: Point, value: Int, inout stop: Bool) -> ()) {
        for index in range {
            var stop = false
            
            closure(point: gridSize.getPositionOfIndex(index), value: buffer[index], stop: &stop)
            
            if stop == true {
                break;
            }
        }
    }
    
    func enumerateRow(row: Int, closure: (point: Point, value: Int, inout stop: Bool) -> ()) {
        enumerateGrid(gridSize.getRangeOfRow(row), closure)
    }
    
    func replaceRow(row: Int, array: Array<Int>) {
        assert(array.count == gridSize.width)
        buffer[gridSize.getRangeOfRow(row)] = array[0..array.count]
    }
    
    func isOverlappedAtPosition(position: Point, grid: Grid) -> Bool {  //  TODO : 메소드 이름 변경, 로직 단순화
        var overlapped = false
        
        grid.enumerateGrid { (point: Point, value: Int, inout stop: Bool) in
            if value != 0 {
                let gridPoint = position + point
                
                if self.gridSize.validatePosition(gridPoint) {
                    overlapped = (self[gridPoint] != 0) ? true : false
                } else {
                    overlapped = true
                }
                
                stop = overlapped
            }
        }
        
        return overlapped
    }
    
    func compactRowOver(row: Int) {
        for var y = row; y > 0; y-- {
            buffer[gridSize.getRangeOfRow(y)] = buffer[gridSize.getRangeOfRow(y - 1)]
        }
        replaceRow(0, array: Array(count: gridSize.width, repeatedValue:0))
    }
    
    func isFullRow(row: Int) -> Bool {
        for index in gridSize.getRangeOfRow(row) {
            if buffer[index] == 0 {
                return false
            }
        }
        
        return true;
    }
    
    func copyGrid(grid: Grid, position: Point) {
        grid.enumerateGrid { (point: Point, value: Int, inout stop: Bool) in
            let gridPoint = point + position
            
            if gridPoint.y >= 0 && value != 0 {
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
            return buffer[gridSize.getIndexOfPosition(position)]
        }
        set {
            assert(gridSize.validatePosition(position), "Index out of range")
            buffer[gridSize.getIndexOfPosition(position)] = newValue
        }
    }

}
