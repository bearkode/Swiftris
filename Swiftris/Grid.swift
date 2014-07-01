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
        self.width = width
        self.height = height
        self.size = width * height
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
            let (x, y) = getPositionWithIndex(index)
            var stop = false
            
            closure(point: Point(x: x, y: y), value: buffer[index], stop: &stop)
            
            if stop == true {
                break;
            }
        }
    }
    
    func enumerateRow(row: Int, closure: (point: Point, value: Int, inout stop: Bool) -> ()) {
        enumerateGrid(getRangeOfRow(row), closure)
    }
    
    func replaceRow(row: Int, array: Array<Int>) {
        assert(array.count == width)
        buffer[getRangeOfRow(row)] = array[0..array.count]
    }
    
    func isOverlappedAtPosition(position: Point, grid: Grid) -> Bool {  //  TODO : 메소드 이름 변경, 로직 단순화
        var overlapped = false
        
        grid.enumerateGrid { (point: Point, value: Int, inout stop: Bool) in
            if value != 0 {
                let gridPoint = position + point
                
                if self.validateCoordinate(gridPoint) {
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
        replaceRow(0, array: Array(count: width, repeatedValue:0))
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
            var px = point.x + position.x
            var py = point.y + position.y
            
            if py >= 0 && value != 0 {
                self[px, py] = value
            }
        }
    }
    
    subscript(x: Int, y: Int) -> Int {
        get {
            assert(validateCoordinate(Point(x: x, y: y)), "Index out of range")
            return buffer[getIndexFrom(x, y: y)]
        }
        set {
            assert(validateCoordinate(Point(x: x, y: y)), "Index out of range")
            buffer[getIndexFrom(x, y: y)] = newValue
        }
    }
    
    subscript(position: Point) -> Int {
        get {
            return self[position.x, position.y]
        }
        set {
            self[position.x, position.y] = newValue
        }
    }
    
    /*
     *      Privates
     */
    
    let width: Int
    let height: Int
    let size: Int
    var buffer: Int[]

    func getRangeOfRow(row: Int) -> Range<Int> {
        return (row * width)..(row * width) + width
    }
    
    func validateCoordinate(point: Point) -> Bool {
        return point.x >= 0 && point.x < width && point.y >= 0 && point.y < height
    }
    
    func getIndexFrom(x: Int, y: Int) -> Int {
        return y * width + x
    }
    
    func getPositionWithIndex(index: Int) -> (x: Int, y: Int) {
        return (index % width, index / width)
    }
    
}
