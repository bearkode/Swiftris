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
    
    init(width: Int, height: Int, array: Int[]) {
        self.gridSize = GridSize(width: width, height: height)
        self.size = gridSize.width * gridSize.height
        self.buffer = Array(count: self.size, repeatedValue: 0)
        
        let count = array.count
        buffer[0..count] = array[0..count]
    }

    convenience init(width: Int, height: Int) {
        self.init(width: width, height: height, array: [])
    }
    
    func enumerateGrid(closure: (point:Point, value: Int, inout stop: Bool) -> ()) {
        enumerateGrid(0..size, closure)
    }
    
    func enumerateGrid(range: Range<Int>, closure: (point: Point, value: Int, inout stop: Bool) -> ()) {
        for index in range {
            var stop = false
            
            closure(point: getPositionOfIndex(index), value: buffer[index], stop: &stop)
            
            if stop == true {
                break;
            }
        }
    }
    
    func enumerateRow(row: Int, closure: (point: Point, value: Int, inout stop: Bool) -> ()) {
        enumerateGrid(getRangeOfRow(row), closure)
    }
    
    func replaceRow(row: Int, array: Array<Int>) {
        assert(array.count == gridSize.width)
        buffer[getRangeOfRow(row)] = array[0..array.count]
    }
    
    func isOverlappedAtPosition(position: Point, grid: Grid) -> Bool {  //  TODO : 메소드 이름 변경, 로직 단순화
        var overlapped = false
        
        grid.enumerateGrid { (point: Point, value: Int, inout stop: Bool) in
            if value != 0 {
                let gridPoint = position + point
                
                if self.validatePosition(gridPoint) {
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
            buffer[getRangeOfRow(y)] = buffer[getRangeOfRow(y - 1)]
        }
        replaceRow(0, array: Array(count: gridSize.width, repeatedValue:0))
    }
    
    func isFullRow(row: Int) -> Bool {
        for index in getRangeOfRow(row) {
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
            assert(validatePosition(position), "Index out of range")
            return buffer[getIndexOfPosition(position)]
        }
        set {
            assert(validatePosition(position), "Index out of range")
            buffer[getIndexOfPosition(position)] = newValue
        }
    }

    /*
     *      Privates
     */
    let gridSize: GridSize
    let size: Int
    var buffer: Int[]

    func getRangeOfRow(row: Int) -> Range<Int> {
        return (row * gridSize.width)..(row * gridSize.width) + gridSize.width
    }
    
    func validatePosition(point: Point) -> Bool {
        return point.x >= 0 && point.x < gridSize.width && point.y >= 0 && point.y < gridSize.height
    }
    
    func getIndexOfPosition(position: Point) -> Int {
        return position.y * gridSize.width + position.x
    }
    
    func getPositionOfIndex(index: Int) -> Point {
        return Point(x: (index % gridSize.width), y: (index / gridSize.width))
    }

}
