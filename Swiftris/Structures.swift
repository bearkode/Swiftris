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
