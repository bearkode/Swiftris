/*
 *  Block+Debugging.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 3..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import Foundation


extension Block: CustomStringConvertible {

    var description: String {
        return "It's Block object \(position.x), \(position.y)"
    }
    
    func debugPrint() {
        var oldY = 0
        self.currentShape.enumerateGrid { (point, value, stop) in
            if oldY != point.y {
                oldY = point.y
                print("", terminator: "\n")
            }
            print("\(value) ", terminator: "");
        }
        print(" ")
    }
    
}