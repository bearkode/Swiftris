/*
 *  Movement.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 3..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import Foundation


internal class Movement {

    // MARK: - init

    internal init(position: Point, shapeCount: Int) {
        self.shapeCount = shapeCount
        self.dropTimer = DropTimer()
        self.rotateIndex = 0
        self.position = position
    }

    // MARK: - internal

    internal var dirty = true
    internal var position: Point {
        didSet {
            self.dirty = true
        }
    }
    internal var nextRotateIndex: Int {
        return (self.rotateIndex - 1) < 0 ? (self.shapeCount - 1) : (self.rotateIndex - 1)
    }
    internal private(set) var rotateIndex: Int {
        didSet {
            self.dirty = true
        }
    }

    internal func turn() {
        self.rotateIndex = self.nextRotateIndex
    }

    internal func down() {
        self.position = self.position.underPoint
    }

    internal func left() {
        self.position = self.position.leftPoint
    }

    internal func right() {
        self.position = self.position.rightPoint
    }

    internal func isTimeToDrop() -> Bool {
        return self.dropTimer.isFired()
    }

    // MARK: - private

    private let shapeCount: Int
    private var dropTimer: DropTimer

}
