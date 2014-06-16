/*
 *  Block.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class Block : Printable {

    var point = Point()
    var color = Color(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.0)
    var grid = Grid(rows: 4, columns: 4)

    var description: String {
        get {
            return "It's Block object"
        }
    }

    init() {
        
    }
    
    func draw() {
        grid.enumerateGrids { (row: Int, column: Int, value: Int) in
            println("row = \(row) column = \(column) : value = \(value)");
        }
    }
    
    func debugPrint() {
        var oldRow = 0
        
        grid.enumerateGrids() { (row, column, value) in
            if oldRow != row {
                oldRow = row
                print("\n")
            }
            
            print("\(value) ");
        }
        
        println(" ")
    }

}