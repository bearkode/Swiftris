/*
 *  Structures.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 13..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


struct Point {
    var x: Double = 0.0
    var y: Double = 0.0
    
    init() {

    }
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}


struct Color {
    var red: Double = 0.0
    var green: Double = 0.0
    var blue: Double = 0.0
    var alpha: Double = 0.0
    
    init(red: Double, green: Double, blue: Double, alpha: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}


struct Grid {
    let width: Int
    let height: Int
    let size: Int
    var grid: Int[]
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.size = width * height
        
        grid = Array(count: size, repeatedValue: 0)
    }
    
    func validateFor(x: Int, y: Int) -> Bool {
        return x >= 0 && x < width && y >= 0 && y < height
    }
    
    func getPositionWithIndex(index: Int) -> (x: Int, y: Int) {
        let x = index % width
        let y = index / width
        
        return (x, y)
    }
    
    func enumerateGrids(closure: (x: Int, y: Int, value: Int) -> ()) {
        for index in 0..size {
            let (x, y) = getPositionWithIndex(index)
            let value = grid[(y * width) + x]
            closure(x: x, y: y, value: value)
        }
    }
    
    subscript(x: Int, y: Int) -> Int {
        get {
            assert(validateFor(x, y: y), "Index out of range")
            
            return grid[(y * width) + x]
        }
        
        set {
            assert(validateFor(x, y: y), "Index out of range")
            
            grid[(y * width) + x] = newValue
        }
    }

}
