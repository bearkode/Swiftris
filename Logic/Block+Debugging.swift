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

    internal var description: String {
        return "Block type: \(self.type) at: \(position.x), \(position.y)"
    }

    internal func debugPrint() {
        var oldY = 0
        self.currentShape.size.points.forEach {
            if oldY != $0.y {
                oldY = $0.y
                print("", terminator: "\n")
            }
            print("\(String(describing: value))", terminator: "")
        }
        print(" ")
    }

}
