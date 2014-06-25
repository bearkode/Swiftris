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

    convenience init() {
        self.init(width: 0, height: 0, array: [])
    }
    
    convenience init(width: Int, height: Int) {
        self.init(width: width, height: height, array: [])
    }
    
    func enumerateGrids(closure: (x: Int, y: Int, value: Int, inout stop: Bool) -> ()) {
        var stop = false
        for index in 0..size {
            let (x, y) = getPositionWithIndex(index)
            closure(x: x, y: y, value: buffer[index], stop: &stop)
            
            if stop == true {
                break
            }
        }
    }
    
    func enumerateRow(row: Int, closure: (x: Int, y: Int, value: Int, inout stop: Bool) -> ()) {
        let range = getRangeOfRow(row)
        for index in range {
            var stop = false
            let (x, y) = getPositionWithIndex(index)
            
            closure(x: x, y: y, value: buffer[index], stop: &stop)
            
            if stop == true {
                break;
            }
        }
    }
    
    func replaceRow(y: Int, array: Array<Int>) {
        assert(array.count == width)
        let range = getRangeOfRow(y)
        buffer[range] = array[0..array.count]
    }
    
    func isOverlappedAtPosition(position: Point, grid: Grid) -> Bool {
        var overlapped = false
        grid.enumerateGrids { (x: Int, y: Int, value: Int, inout stop: Bool) in
            if value != 0 {
                var px = position.x + x
                var py = position.y - y
                
                println("\(px), \(py)")
                
                if py < 0 || px < 0  || px >= self.width || py >= self.height {
                    overlapped = true
                } else {
                    if self[px, py] != 0 {
                        overlapped = true
                        stop = true
                    }
                }
            }
        }
        
        return overlapped
    }
    
    func compactRowOver(row: Int) {
        for var y = row; y < (height - 1); y++ {
            var rangeSrc = getRangeOfRow(y + 1)
            var rangeDst = getRangeOfRow(y)
            buffer[rangeDst] = buffer[rangeSrc]
        }
        replaceRow(height - 1, array: Array(count: width, repeatedValue:0))
        println("\(buffer)")
    }
    
    func isFullRow(row: Int) -> Bool {
        var hasEmpty = false

        self.enumerateRow(row) { ( x: Int, y: Int, value: Int, inout stop: Bool) in
            if value == 0 {
                hasEmpty = true
                stop = true
            }
        }
        
        return !hasEmpty
    }
    
    func setValuesAtPosition(position: Point, grid: Grid) {
        var stop = false
        grid.enumerateGrids { (x: Int, y: Int, value: Int, inout stop: Bool) in
            var px = position.x + x
            var py = position.y - y
            
            if py >= 0 && value != 0 {
                self[px, py] = value
            }
        }
    }
    
    subscript(x: Int, y: Int) -> Int {
        get {
            assert(validateFor(x, y: y), "Index out of range")
            return buffer[getIndexFrom(x, y: y)]
        }
        
        set {
            assert(validateFor(x, y: y), "Index out of range")
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
    
    func validateFor(x: Int, y: Int) -> Bool {
        return x >= 0 && x < width && y >= 0 && y < height
    }
    
    func getIndexFrom(x: Int, y: Int) -> Int {
        return y * width + x
    }
    
    func getPositionWithIndex(index: Int) -> (x: Int, y: Int) {
        return (index % width, index / width)
    }
    
}
