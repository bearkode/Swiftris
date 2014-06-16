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
    let rows: Int
    let columns: Int
    let size: Int
    var grid: Int[]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.size = rows * columns
        
        grid = Array(count: size, repeatedValue: 0)
    }
    
    func validateFor(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    func getRowAndColumnWithIndex(index: Int) -> (row: Int, column: Int) {
        let row = index / columns
        let column = index % columns
        
        return (row, column)
    }
    
    func enumerateGrids(closure: (row: Int, column: Int, value: Int) -> ()) {
        for index in 0..size {
            let (row, column) = getRowAndColumnWithIndex(index)
            let value = grid[(row * columns) + column]
            closure(row: row, column: column, value: value)
        }
    }
    
    subscript(row: Int, column: Int) -> Int {
        get {
            assert(validateFor(row, column: column), "Index out of range")
            
            return grid[(row * columns) + column]
        }
        
        set {
            assert(validateFor(row, column: column), "Index out of range")
            
            grid[(row * columns) + column] = newValue
        }
    }

}
