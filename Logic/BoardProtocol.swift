//
//  BoardProtocol.swift
//  Logic
//
//  Created by bearkode on 14/02/2019.
//  Copyright © 2019 bearkode. All rights reserved.
//

import Foundation


internal protocol BoardProtocol {

    func isPossible(at: Point, withGrid: Grid<Int>) -> Bool

}
