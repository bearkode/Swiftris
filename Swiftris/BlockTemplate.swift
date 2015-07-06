/*
 *  BlockTemplate.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 6..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import Foundation


struct BlockTemplate {

    static let blockA = [Grid(width: 4, height: 4, array: [0, 1, 1, 0,
                                                           0, 1, 1, 0])]
    static let blockB = [Grid(width: 4, height: 4, array: [0, 2, 0, 0,
                                                           0, 2, 0, 0,
                                                           0, 2, 0, 0,
                                                           0, 2, 0, 0]),
                         Grid(width: 4, height: 4, array: [0, 0, 0, 0,
                                                           2, 2, 2, 2])]
    static let blockC = [Grid(width: 4, height: 4, array: [0, 3, 3, 0,
                                                           0, 0, 3, 0,
                                                           0, 0, 3, 0]),
                         Grid(width: 4, height: 4, array: [0, 0, 3, 0,
                                                           3, 3, 3, 0]),
                         Grid(width: 4, height: 4, array: [0, 3, 0, 0,
                                                           0, 3, 0, 0,
                                                           0, 3, 3, 0]),
                         Grid(width: 4, height: 4, array: [3, 3, 3, 0,
                                                           3, 0, 0, 0])]
    static let blockD = [Grid(width: 4, height: 4, array: [0, 4, 4, 0,
                                                           0, 4, 0, 0,
                                                           0, 4, 0, 0]),
                         Grid(width: 4, height: 4, array: [4, 4, 4, 0,
                                                           0, 0, 4, 0]),
                         Grid(width: 4, height: 4, array: [0, 0, 4, 0,
                                                           0, 0, 4, 0,
                                                           0, 4, 4, 0]),
                         Grid(width: 4, height: 4, array: [4, 0, 0, 0,
                                                           4, 4, 4, 0])]
    static let blockE = [Grid(width: 4, height: 4, array: [0, 5, 0, 0,
                                                           5, 5, 5, 0]),
                         Grid(width: 4, height: 4, array: [0, 5, 0, 0,
                                                           0, 5, 5, 0,
                                                           0, 5, 0, 0]),
                         Grid(width: 4, height: 4, array: [0, 0, 0, 0,
                                                           5, 5, 5, 0,
                                                           0, 5, 0, 0]),
                         Grid(width: 4, height: 4, array: [0, 5, 0, 0,
                                                           5, 5, 0, 0,
                                                           0, 5, 0, 0])]
    static let blockF = [Grid(width: 4, height: 4, array: [0, 6, 0, 0,
                                                           6, 6, 0, 0,
                                                           6, 0, 0, 0]),
                         Grid(width: 4, height: 4, array: [6, 6, 0, 0,
                                                           0, 6, 6, 0])]
    static let blockG = [Grid(width: 4, height: 4, array: [7, 0, 0, 0,
                                                           7, 7, 0, 0,
                                                           0, 7, 0, 0]),
                         Grid(width: 4, height: 4, array: [0, 7, 7, 0,
                                                           7, 7, 0, 0])]

}