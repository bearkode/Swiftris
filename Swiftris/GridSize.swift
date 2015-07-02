/*
 *  GridSize.swift
 *  Swiftris
 *
 *  Created by cgkim on 2014. 7. 2..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


struct GridSize {
    
    let width: Int
    let height: Int

    var indexRange: Range<Int> {
        get {
            return 0..<(width * height)
        }
    }
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }

    init () {
        self.init(width: 0, height: 0)
    }

    func enumerateGrids(closure: (position: Point) -> ()) {
        for index in indexRange {
            closure(position: positionOfIndex(index))
        }
    }
    
    func validatePosition(position: Point) -> Bool {
        return position.x >= 0 && position.x < width && position.y >= 0 && position.y < height
    }
    
    func indexOfPosition(position: Point) -> Int {
        return position.y * width + position.x
    }
    
    func positionOfIndex(index: Int) -> Point {
        return Point(x: index % width, y: index / width)
    }
    
    func rangeOfRow(row: Int) -> Range<Int> {
        return (row * width)..<((row * width) + width)
    }
    
}


func == (left: GridSize, right: GridSize) -> Bool {
    return (left.width == right.width) && (left.height == right.height)
}

