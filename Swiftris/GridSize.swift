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
    
    var width: Int = 0
    var height: Int = 0
    var indexRange: Range<Int> {
        get {
            return 0..(width * height)
        }
    }
    
    init () {
        
    }
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    func enumerateGrids(closure: (position: Point) -> ()) {
        for index in indexRange {
            closure(position: getPositionOfIndex(index))
        }
    }
    
    func validatePosition(position: Point) -> Bool {
        return position.x >= 0 && position.x < width && position.y >= 0 && position.y < height
    }
    
    func getIndexOfPosition(position: Point) -> Int {
        return position.y * width + position.x
    }
    
    func getPositionOfIndex(index: Int) -> Point {
        return Point(x: index % width, y: index / width)
    }
    
    func getRangeOfRow(row: Int) -> Range<Int> {
        return (row * width)..((row * width) + width)
    }
    
}


@infix func == (left: GridSize, right: GridSize) -> Bool {
    return (left.width == right.width) && (left.height == right.height)
}

