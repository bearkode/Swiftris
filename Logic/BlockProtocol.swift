//
//  BlockProtocol.swift
//  Logic
//
//  Created by bearkode on 14/02/2019.
//  Copyright © 2019 bearkode. All rights reserved.
//

import Foundation


internal protocol BlockProtocol {

    var position: Point { get }
    var currentShape: Grid<Int> { get }
    var nextShape: Grid<Int> { get }

    func turn()
    func moveLeft()
    func moveRight()

}
