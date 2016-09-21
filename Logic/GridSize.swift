/*
 *  GridSize.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 7. 2..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


public struct GridSize {
    
    public var width: Int
    public var height: Int
    
    let indexRange: CountableRange<Int>
    
    // MARK: -
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.indexRange = 0..<(width * height)
    }

    public init () {
        self.init(width: 0, height: 0)
    }
    
    //  MARK: -
    public func enumerate(_ closure: (_: Point) -> ()) {
        for index in self.indexRange {
            closure(self.position(ofIndex: index))
        }
    }
    
    func isValidPosition(_ position: Point) -> Bool {
        return position.x >= 0 && position.x < self.width && position.y >= 0 && position.y < self.height
    }
    
    func index(ofPosition position: Point) -> Int {
        return position.y * self.width + position.x
    }
    
    func position(ofIndex index: Int) -> Point {
        return Point(x: index % self.width, y: index / self.width)
    }
    
    func range(ofRow row: Int) -> CountableRange<Int> {
        return (row * self.width)..<((row * self.width) + self.width)
    }
    
}


func == (left: GridSize, right: GridSize) -> Bool {
    return (left.width == right.width) && (left.height == right.height)
}
