/*
 *  Movement.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 3..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import Foundation


class Movement {

    // MARK: - init

    init(position: Point, shapeCount: Int) {
        self.shapeCount = shapeCount
        self.dropTimer = DropTimer()
        self.rotateIndex = 0
        self.position = position
    }

    // MARK: - internal

    var dirty = true
    var position: Point {
        didSet {
            self.dirty = true
        }
    }
    var nextRotateIndex: Int {
        return (self.rotateIndex - 1) < 0 ? (self.shapeCount - 1) : (self.rotateIndex - 1)
    }
    private(set) var rotateIndex: Int {
        didSet {
            self.dirty = true
        }
    }

    func turn() {
        self.rotateIndex = self.nextRotateIndex
    }

    func down() {
        self.position = self.position.underPoint
    }

    func left() {
        self.position = self.position.leftPoint
    }

    func right() {
        self.position = self.position.rightPoint
    }

    func isTimeToDrop() -> Bool {
        return self.dropTimer.isFired()
    }

    // MARK: - private

    private let shapeCount: Int
    private var dropTimer: DropTimer

}
