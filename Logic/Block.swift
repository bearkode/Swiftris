/*
 *  Block.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


internal class Block: DirtyCheckable {

    // MARK: - init

    internal init(type: BlockType, position: Point = Point()) {
        self.type = type
        self.grids = type.grids
        self.movement = Movement(position: position, shapeCount: self.grids.count)
        self.position = position
        self.updateCurrentShape()
    }

    // MARK: - internal

    internal let grids: [Grid<Int>]
    internal var currentShape: Grid = Grid<Int>(size: Size(width: 4, height: 4))
    internal var nextShape: Grid<Int> {
        return self.grids[self.movement.nextRotateIndex]
    }
    internal var dirty: Bool {
        set {
            self.movement.dirty = newValue
        }
        get {
            return self.movement.dirty
        }
    }
    internal var position: Point {
        set {
            self.movement.position = newValue
        }
        get {
            return self.movement.position
        }
    }
    internal var timeToDrop: Bool {
        return self.movement.isTimeToDrop()
    }
    internal let type: BlockType

    // MARK: -

    internal func turn() {
        self.movement.turn()
        self.updateCurrentShape()
    }

    internal func moveDown() {
        self.movement.down()
    }

    internal func moveLeft() {
        self.movement.left()
    }

    internal func moveRight() {
        self.movement.right()
    }

    // MARK: -

    internal func contains(position: Point) -> Bool {
        return (position.x >= self.position.x &&
                position.x < self.position.x + self.currentShape.size.width &&
                position.y >= self.position.y &&
                position.y < self.position.y + self.currentShape.size.height)
    }

    internal func value(at position: Point) -> Int? {
        guard self.contains(position: position) == true else {
            return nil
        }

        return self.currentShape[self.positionInBlock(from: position)]
    }

    internal func positionInBlock(from position: Point) -> Point {
        return position - self.position
    }

    // MARK: - private

    private let movement: Movement
    private func updateCurrentShape() {
        if self.grids.isEmpty == false {
            self.currentShape = self.grids[self.movement.rotateIndex]
        }
    }

}
