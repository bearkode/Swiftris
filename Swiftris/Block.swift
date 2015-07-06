/*
 *  Block.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class Block {
    
    var currentGrid: Grid = Grid(width: 4, height: 4)
    var nextGrid: Grid {
        get {
            return self.grids[self.movement.nextRotateIndex]
        }
    }

    var position: Point {
        set {
            self.movement.position = newValue
        }
        get {
            return self.movement.position
        }
    }
    
    required init() {
        self.grids = self.dynamicType.gridsForBlock()
        self.movement = Movement(position: Point(), shapeCount: self.grids.count)
        self.updateCurrentGrid()
    }
    
    class func gridsForBlock() -> [Grid] {
        return []
    }
    
    /**
        Movements
    */
    
    func turn() {
        self.movement.turn()
        self.updateCurrentGrid()
    }
    
    func moveDown() {
        self.movement.down()
    }

    func moveLeft() {
        self.movement.left()
    }
    
    func moveRight() {
        self.movement.right()
    }
    
    func isTimeToDrop() -> Bool {
        return self.movement.isTimeToDrop()
    }
    
    /**
    
    */
    
    func containsPosition(position: Point) -> Bool {
        return (position.x >= self.position.x &&
                position.x < self.position.x + self.currentGrid.size.width &&
                position.y >= self.position.y &&
                position.y < self.position.y + self.currentGrid.size.height)
    }

    func valueAtPosition(position: Point) -> Int {
        if self.containsPosition(position) {
            return self.currentGrid[self.blockPositionFromPosition(position)]
        }

        return 0
    }

    func blockPositionFromPosition(position: Point) -> Point {
        return Point(x: (position.x - self.position.x), y: (position.y - self.position.y))
    }

    //  MARK: - Privates

    var grids: [Grid]
    let movement: Movement
    
    private func updateCurrentGrid() {
        self.currentGrid = self.grids[self.movement.rotateIndex]
    }

}