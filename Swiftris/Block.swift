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

    var grids: Grid[] = Array()
    
    var position = Point()
    var currentGrid = Grid(width: 4, height: 4)
    var rotateIndex = 0

    var description: String {
        get {
            return "It's Block object"
        }
    }

    init() {
        generateTemplate()
        updateGrid()
    }
    
    func generateTemplate() {
        /* TO BE OVERRIDE  */
    }
    
    func updateGrid() {
        currentGrid = grids[rotateIndex]
    }
    
    func increaseRotateIndex() {
        rotateIndex++
        rotateIndex = rotateIndex > (grids.count - 1) ? 0 : rotateIndex
    }
    
    func turn() {
        increaseRotateIndex()
        updateGrid()
    }
    
    func draw() {
        currentGrid.enumerateGrids { (x: Int, y: Int, value: Int) in
            println("x = \(x) y = \(y) : value = \(value)");
        }
    }
    
    func debugPrint() {
        var oldY = 0
        currentGrid.enumerateGrids() { (x, y, value) in
            if oldY != y {
                oldY = y
                print("\n")
            }
            print("\(value) ");
        }
        println(" ")
    }
    
    func moveLeft() {
        position.x--
    }
    
    func moveRight() {
        position.x++
    }

}