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
    var grid = Grid(width: 4, height: 4)

    var description: String {
        get {
            return "It's Block object"
        }
    }

    init() {
        
    }
    
    func draw() {
        grid.enumerateGrids { (x: Int, y: Int, value: Int) in
            println("x = \(x) y = \(y) : value = \(value)");
        }
    }
    
    func debugPrint() {
        var oldY = 0
        
        grid.enumerateGrids() { (x, y, value) in
            
            if oldY != y {
                oldY = y
                print("\n")
            }
            
            print("\(value) ");
        }
        
        println(" ")
    }

}