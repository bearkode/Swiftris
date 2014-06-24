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
    
    var x: Int = 0
    var y: Int = 0
    
    init() {

    }
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}


struct GridSize : Printable {
    
    var width: Int = 0
    var height: Int = 0
    
    var description: String {
        get {
            return "GridSize = \(width), \(height)"
        }
    }
    
    init() {

    }
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    func enumerateGrids(closure: (position: Point) -> ()) {
        for index in 0..(width * height) {
            let (x, y) = getPositionWithIndex(index)
            let position = Point(x: x, y: y)
            closure(position: position)
        }
    }
    
    func getPositionWithIndex(index: Int) -> (x: Int, y: Int) {
        return (index % width, index / width)
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
