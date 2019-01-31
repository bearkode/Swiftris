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
        return "Block type: \(self.type) at: \(position.x), \(position.y)"
    }

    func debugPrint() {
        var oldY = 0
        self.currentShape.enumerate { (point, value, _) in
            if oldY != point.y {
                oldY = point.y
                print("", terminator: "\n")
            }
            print("\(value) ", terminator: "")
        }
        print(" ")
    }

}
