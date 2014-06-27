/*
 *  Grid.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 18..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


class Grid {

    init(width: Int, height: Int, array: Int[]) {
        self.width = width
        self.height = height
        self.size = width * height
        self.buffer = Array(count: self.size, repeatedValue: 0)
        
        let count = array.count
        buffer[0..count] = array[0..count]
    }

    convenience init() {
        self.init(width: 0, height: 0, array: [])
    }
    
    convenience init(width: Int, height: Int) {
        self.init(width: width, height: height, array: [])
    }
    
    func enumerateGrids(closure: (x: Int, y: Int, value: Int, inout stop: Bool) -> ()) {
        var stop = false
        for index in 0..size {
            let (x, y) = getPositionWithIndex(index)
            
            closure(x: x, y: y, value: buffer[index], stop: &stop)
            
            if stop == true {
                break
            }
        }
    }
    
    func enumerateRow(row: Int, closure: (x: Int, y: Int, value: Int, inout stop: Bool) -> ()) {    //  TODO : closure loop를 중단시키는 더 효율적인 방법은 없나?
        let range = getRangeOfRow(row)

        for index in range {
            var stop = false
            let (x, y) = getPositionWithIndex(index)
            
            closure(x: x, y: y, value: buffer[index], stop: &stop)
            
            if stop == true {
                break;
            }
        }
    }
    
    func replaceRow(y: Int, array: Array<Int>) {
        assert(array.count == width)
        buffer[getRangeOfRow(y)] = array[0..array.count]
    }
    
    func isOverlappedAtPosition(position: Point, grid: Grid) -> Bool {  //  TODO : 메소드 이름 변경, 로직 단순화
        var overlapped = false
        grid.enumerateGrids { (x: Int, y: Int, value: Int, inout stop: Bool) in
            if value != 0 {
                var px = position.x + x
                var py = position.y + y

                if py < 0 || px < 0  || px >= self.width || py >= self.height {
                    overlapped = true
                } else {
                    if self[px, py] != 0 {
                        overlapped = true
                        stop = true
                    }
                }
            }
        }
        
        return overlapped
    }
    
    func compactRowOver(row: Int) {     //  TODO : 메모리 왕창 복사하면 안됨? 구간이 중복되면 데이터가 깨질려나?
        for var y = row; y > 0; y-- {
            buffer[getRangeOfRow(y)] = buffer[getRangeOfRow(y - 1)]
        }
        replaceRow(0, array: Array(count: width, repeatedValue:0))
    }
    
    func isFullRow(row: Int) -> Bool {  //  TODO : getRangeOfRow를 사용한 루프로 재구성
        var hasEmpty = false

        self.enumerateRow(row) { ( x: Int, y: Int, value: Int, inout stop: Bool) in
            if value == 0 {
                hasEmpty = true
                stop = true
            }
        }
        
        return !hasEmpty
    }
    
    func setValuesAtPosition(position: Point, grid: Grid) { // TODO : 이름이 모호함
        var stop = false
        grid.enumerateGrids { (x: Int, y: Int, value: Int, inout stop: Bool) in
            var px = position.x + x
            var py = position.y + y
            
            if py >= 0 && value != 0 {
                self[px, py] = value
            }
        }
    }
    
    subscript(x: Int, y: Int) -> Int {
        get {
            assert(validateCoordinate(x, y: y), "Index out of range")
            return buffer[getIndexFrom(x, y: y)]
        }
        
        set {
            assert(validateCoordinate(x, y: y), "Index out of range")
            buffer[getIndexFrom(x, y: y)] = newValue
        }
    }
    
    subscript(position: Point) -> Int {
        get {
            return self[position.x, position.y]
        }
        
        set {
            self[position.x, position.y] = newValue
        }
    }
    
    /*
     *      Privates
     */
    
    let width: Int
    let height: Int
    let size: Int
    var buffer: Int[]

    func getRangeOfRow(row: Int) -> Range<Int> {
        return (row * width)..(row * width) + width
    }
    
    func validateCoordinate(x: Int, y: Int) -> Bool {
        return x >= 0 && x < width && y >= 0 && y < height
    }
    
    func getIndexFrom(x: Int, y: Int) -> Int {
        return y * width + x
    }
    
    func getPositionWithIndex(index: Int) -> (x: Int, y: Int) {
        return (index % width, index / width)
    }
    
}
