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

    var description: String {
        get {
            return "It's Block object \(position.x), \(position.y)"
        }
    }
    
    var leftPosition: Point {
        get {
            return Point(x: position.x - 1, y: position.y)
        }
    }
    
    var rightPosition: Point {
        get {
            return Point(x: position.x + 1, y: position.y)
        }
    }
    
    var lowPosition: Point {
        get {
            return Point(x: position.x, y: position.y + 1)
        }
    }
    
    var nextGrid: Grid {
        get {
            var nextIndex = nextRotateIndex()
            return grids[nextIndex]
        }
    }

    init() {
        generateTemplate()
        updateCurrentGrid()
    }
    
    func generateTemplate() {
        /* TO BE OVERRIDE  */
    }
    
    func turn() {
        increaseRotateIndex()
        updateCurrentGrid()
    }
    
    func moveDown() {
        position.y++
        dirty = true
    }

    func moveLeft() {
        position.x--
        dirty = true
    }
    
    func moveRight() {
        position.x++
        dirty = true
    }
    
    func containsPosition(position: Point) -> Bool {
        return (position.x >= self.position.x &&
                position.x < self.position.x + currentGrid.gridSize.width &&
                position.y >= self.position.y &&
                position.y < self.position.y + currentGrid.gridSize.height)
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
                print("\n")
            }
            print("\(value) ");
        }
        println(" ")
    }
    
    /*
     *      Privates
     */
    var grids: Grid[] = Array()
    var position = Point()
    var currentGrid = Grid(width: 4, height: 4)
    var rotateIndex = 0
    var dirty = true
    
    func appendTemplate(grid: Grid) {
        grids += grid
    }
 
    func increaseRotateIndex() {
        rotateIndex = nextRotateIndex()
    }

    func nextRotateIndex() -> Int {
        var result = rotateIndex - 1
        return result < 0 ? (grids.count - 1) : result
    }
    
    func updateCurrentGrid() {
        currentGrid = grids[rotateIndex]
        dirty = true
    }

    func blockPositionFromPosition(position: Point) -> Point {
        return Point(x: (position.x - self.position.x), y: (position.y - self.position.y))
    }
}