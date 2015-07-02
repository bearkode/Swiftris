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

    var nextGrid: Grid {
        get {
            return self.grids[self.nextRotateIndex()]
        }
    }

    required init() {
        self.generateTemplate()
        self.updateCurrentGrid()
    }
    
    func generateTemplate() {
        /* TO BE OVERRIDE  */
    }
    
    func turn() {
        self.rotateIndex = self.nextRotateIndex()
        self.updateCurrentGrid()
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
        return self.dropTimer.isTimeToDrop()
    }
    
    func containsPosition(position: Point) -> Bool {
        return (position.x >= self.position.x &&
                position.x < self.position.x + self.currentGrid.width &&
                position.y >= self.position.y &&
                position.y < self.position.y + self.currentGrid.height)
    }

    func valueAtPosition(position: Point) -> Int {
        if self.containsPosition(position) {
            return self.currentGrid[self.blockPositionFromPosition(position)]
        } else {
            return 0
        }
    }
    
    //  MARK: - Privates

    private var grids: [Grid] = Array()

    var position: Point = Point() {
        didSet {
            self.dirty = true;
        }
    }
    
    var currentGrid: Grid = Grid(width: 4, height: 4) {
        didSet {
            self.dirty = true;
        }
    }
    
    private var rotateIndex = 0
    private var dropTimer = DropTimer()
    var dirty = true
    
    func appendTemplate(grid: Grid) {
        self.grids.append(grid)
    }
 
    private func nextRotateIndex() -> Int {
        return (self.rotateIndex - 1) < 0 ? (self.grids.count - 1) : (self.rotateIndex - 1)
    }
    
    func updateCurrentGrid() {
        self.currentGrid = self.grids[rotateIndex]
    }

    func blockPositionFromPosition(position: Point) -> Point {
        return Point(x: (position.x - self.position.x), y: (position.y - self.position.y))
    }
    
}