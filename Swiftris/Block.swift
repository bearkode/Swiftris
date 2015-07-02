/*
 *  Block.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class Block : CustomStringConvertible {

    var description: String {
        get {
            return "It's Block object \(position.x), \(position.y)"
        }
    }
    
    var nextGrid: Grid {
        get {
            return grids[nextRotateIndex()]
        }
    }

    required init() {
        generateTemplate()
        updateCurrentGrid()
        dropCount = dropCountForLevel
    }
    
    func generateTemplate() {
        /* TO BE OVERRIDE  */
    }
    
    func turn() {
        increaseRotateIndex()
        updateCurrentGrid()
    }
    
    func moveDown() {
        self.position = self.position.downPoint;
    }

    func moveLeft() {
        self.position = self.position.leftPoint;
    }
    
    func moveRight() {
        self.position = self.position.rightPoint
    }
    
    func isTimeToDrop() -> Bool {
        if dropCount-- < 0 {
            dropCount = dropCountForLevel
            return true
        } else {
            return false
        }
    }
    
    func containsPosition(position: Point) -> Bool {
        return (position.x >= self.position.x &&
                position.x < self.position.x + self.currentGrid.width &&
                position.y >= self.position.y &&
                position.y < self.position.y + self.currentGrid.height)
    }

    func valueAtPosition(position: Point) -> Int {
        if containsPosition(position) {
            return currentGrid[blockPositionFromPosition(position)]
        } else {
            return 0
        }
    }
    
    func debugPrint() {
        var oldY = 0
        currentGrid.enumerateGrid { (point, value, stop) in
            if oldY != point.y {
                oldY = point.y
                print("\n", appendNewline: false)
            }
            print("\(value) ", appendNewline: false);
        }
        print(" ")
    }
    
    //  MARK: - Privates

    private var grids: [Grid] = Array()

    var position: Point = Point() {
        didSet {
            dirty = true;
        }
    }
    
    var currentGrid: Grid = Grid(width: 4, height: 4) {
        didSet {
            dirty = true;
        }
    }
    
    private var rotateIndex = 0
    private let dropCountForLevel = 5
    private var dropCount = 0
    var dirty = true
    
    func appendTemplate(grid: Grid) {
        grids.append(grid)
    }
 
    func increaseRotateIndex() {
        rotateIndex = nextRotateIndex()
    }

    func nextRotateIndex() -> Int {
        let result = rotateIndex - 1
        return result < 0 ? (grids.count - 1) : result
    }
    
    func updateCurrentGrid() {
        currentGrid = grids[rotateIndex]
    }

    func blockPositionFromPosition(position: Point) -> Point {
        return Point(x: (position.x - self.position.x), y: (position.y - self.position.y))
    }
    
}