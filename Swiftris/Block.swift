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

    var currentGrid: Grid = Grid(width: 4, height: 4) {
        didSet {
            self.dirty = true;
        }
    }

    var nextGrid: Grid {
        get {
            return self.grids[self.nextRotateIndex()]
        }
    }

    var position: Point = Point() {
        didSet {
            self.dirty = true;
        }
    }
    
    var dirty = true
    
    required init() {
        self.grids = []
    }
    
    /**
        Movements
    */
    
    func turn() {
        self.rotateIndex = self.nextRotateIndex()
        self.updateCurrentGrid()
    }
    
    func moveDown() {
        self.position = self.position.underPoint;
    }

    func moveLeft() {
        self.position = self.position.leftPoint;
    }
    
    func moveRight() {
        self.position = self.position.rightPoint
    }
    
    func isTimeToDrop() -> Bool {
        return self.dropTimer.isTimeToDrop()
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

    var grids: [Grid] {
        didSet {
            self.updateCurrentGrid()
        }
    }
    private var rotateIndex = 0
    private var dropTimer = DropTimer()
    
    private func nextRotateIndex() -> Int {
        return (self.rotateIndex - 1) < 0 ? (self.grids.count - 1) : (self.rotateIndex - 1)
    }
    
    private func updateCurrentGrid() {
        self.currentGrid = self.grids[rotateIndex]
    }

}