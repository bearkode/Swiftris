/*
 *  Block.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class Block: DirtyCheckable {

    //  MARK: - init

    init(type: BlockType, position: Point = Point()) {
        self.type = type
        self.grids = type.grids
        self.movement = Movement(position: position, shapeCount: self.grids.count)
        self.position = position
        self.updateCurrentGrid()
    }

    // MARK: - internal

    var grids: [Grid]
    var currentShape: Grid = Grid(size: GridSize(width: 4, height: 4))
    var nextShape: Grid {
        return self.grids[self.movement.nextRotateIndex]
    }
    var dirty: Bool {
        set {
            self.movement.dirty = newValue
        }
        get {
            return self.movement.dirty
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
    var timeToDrop: Bool {
        return self.movement.isTimeToDrop()
    }
    private(set) var type: BlockType

    //  MARK: -

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
    
    //  MARK: -

    func contains(position: Point) -> Bool {
        return (position.x >= self.position.x &&
                position.x < self.position.x + self.currentShape.size.width &&
                position.y >= self.position.y &&
                position.y < self.position.y + self.currentShape.size.height)
    }

    func value(at position: Point) -> Int {
        if self.contains(position: position) {
            return self.currentShape[self.positionInBlock(from: position)]
        }

        return 0
    }

    func positionInBlock(from position: Point) -> Point {
        return Point(x: (position.x - self.position.x), y: (position.y - self.position.y))
    }

    //  MARK: - private

    private let movement: Movement
    private func updateCurrentGrid() {
        if self.grids.count > 0 {
            self.currentShape = self.grids[self.movement.rotateIndex]
        }
    }

}
