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
    
    func enumerateGrids(closure: (x: Int, y: Int, value: Int) -> ()) {
        for index in 0..size {
            let (x, y) = getPositionWithIndex(index)
            let value = buffer[index]
            closure(x: x, y: y, value: value)
        }
    }
    
    func replaceRow(y: Int, array: Array<Int>) {
        assert(array.count == width)
        let range = rangeOfRow(y)
        buffer[range] = array[range]
    }
    
    func isOverlappedAtPosition(position: Point, grid: Grid) -> Bool {
        var overlapped = false
        grid.enumerateGrids { (x: Int, y: Int, value: Int) in
            if value != 0 {
                var px = position.x + x
                var py = position.y - y
                
                println("\(px), \(py)")
                
                if py < 0 {
                    overlapped = true
                }
                else
                {
                    if self[px, py] != 0 {
                        overlapped = true   //  TODO : 찾았으면 enum을 멈추자.
                    }
                }
            }
        }
        
        return overlapped
    }
    
    func setValuesAtPosition(position: Point, grid: Grid) {
        grid.enumerateGrids { (x: Int, y: Int, value: Int) in
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
            return buffer[indexFrom(x, y: y)]
        }
        
        set {
            assert(validateFor(x, y: y), "Index out of range")
            buffer[indexFrom(x, y: y)] = newValue
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

    func indexFrom(x: Int, y: Int) -> Int {
        return y * width + x
    }
    
    func rangeOfRow(row: Int) -> Range<Int> {
        return (row * width)..(row * width) + width
    }
    
    func validateFor(x: Int, y: Int) -> Bool {
        return x >= 0 && x < width && y >= 0 && y < height
    }
    
    func getPositionWithIndex(index: Int) -> (x: Int, y: Int) {
        return (index % width, index / width)
    }
    
}
