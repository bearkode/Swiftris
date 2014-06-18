/*
 *  Grid.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 18..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


struct Grid {

    init(width: Int, height: Int, array: Int[]) {
        self.width = width
        self.height = height
        self.size = width * height
        self.buffer = Array(count: self.size, repeatedValue: 0)
        
        let count = array.count
        buffer[0..count] = array[0..count]
    }

    init(width: Int, height: Int) {
        self.init(width: width, height: height, array: [])
    }
    
    func enumerateGrids(closure: (x: Int, y: Int, value: Int) -> ()) {
        for index in 0..size {
            let (x, y) = getPositionWithIndex(index)
            let value = buffer[indexFrom(x, y: y)]
            closure(x: x, y: y, value: value)
        }
    }
    
    func appendWithRowArray(array: Array<Int>, y: Int) {
        assert(array.count == width)
        for var x = 0; x < array.count; x++ {
            buffer[indexFrom(x, y: y)] = array[x]
        }
    }
    
    subscript(x: Int, y: Int) -> Int {
        get {
            assert(validateFor(x, y: y), "Index out of range")
            return buffer[indexFrom(x, y:y)]
        }
        
        set {
            assert(validateFor(x, y: y), "Index out of range")
            buffer[indexFrom(x, y: y)] = newValue
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
    
    func validateFor(x: Int, y: Int) -> Bool {
        return x >= 0 && x < width && y >= 0 && y < height
    }
    
    func getPositionWithIndex(index: Int) -> (x: Int, y: Int) {
        return (index % width, index / width)
    }
    
}
