/*
 *  BlockTemplate.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 6..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import Foundation


extension Grid where T == Int {

    internal convenience init(size: Size, array: [Int]) {
        self.init(size: size, array: array, defaultValue: 0)
    }

}


internal enum BlockTemplate {

    internal static let box = [Grid(size: BlockTemplate.size, array: [0, 1, 1, 0,
                                                                      0, 1, 1, 0])]
    internal static let bar = [Grid(size: BlockTemplate.size, array: [0, 2, 0, 0,
                                                                      0, 2, 0, 0,
                                                                      0, 2, 0, 0,
                                                                      0, 2, 0, 0]),
                               Grid(size: BlockTemplate.size, array: [0, 0, 0, 0,
                                                                      2, 2, 2, 2])]
    internal static let foldA = [Grid(size: BlockTemplate.size, array: [0, 3, 3, 0,
                                                                        0, 0, 3, 0,
                                                                        0, 0, 3, 0]),
                                 Grid(size: BlockTemplate.size, array: [0, 0, 3, 0,
                                                                        3, 3, 3, 0]),
                                 Grid(size: BlockTemplate.size, array: [0, 3, 0, 0,
                                                                        0, 3, 0, 0,
                                                                        0, 3, 3, 0]),
                                 Grid(size: BlockTemplate.size, array: [3, 3, 3, 0,
                                                                        3, 0, 0, 0])]
    internal static let foldB = [Grid(size: BlockTemplate.size, array: [0, 4, 4, 0,
                                                                        0, 4, 0, 0,
                                                                        0, 4, 0, 0]),
                                 Grid(size: BlockTemplate.size, array: [4, 4, 4, 0,
                                                                        0, 0, 4, 0]),
                                 Grid(size: BlockTemplate.size, array: [0, 0, 4, 0,
                                                                        0, 0, 4, 0,
                                                                        0, 4, 4, 0]),
                                 Grid(size: BlockTemplate.size, array: [4, 0, 0, 0,
                                                                        4, 4, 4, 0])]
        internal static let bump = [Grid(size: BlockTemplate.size, array: [0, 5, 0, 0,
                                                                           5, 5, 5, 0]),
                                    Grid(size: BlockTemplate.size, array: [0, 5, 0, 0,
                                                                           0, 5, 5, 0,
                                                                           0, 5, 0, 0]),
                                    Grid(size: BlockTemplate.size, array: [0, 0, 0, 0,
                                                                           5, 5, 5, 0,
                                                                           0, 5, 0, 0]),
                                    Grid(size: BlockTemplate.size, array: [0, 5, 0, 0,
                                                                           5, 5, 0, 0,
                                                                           0, 5, 0, 0])]
    internal static let zigzagA = [Grid(size: BlockTemplate.size, array: [0, 6, 0, 0,
                                                                          6, 6, 0, 0,
                                                                          6, 0, 0, 0]),
                                   Grid(size: BlockTemplate.size, array: [6, 6, 0, 0,
                                                                          0, 6, 6, 0])]
    internal static let zigzagB = [Grid(size: BlockTemplate.size, array: [7, 0, 0, 0,
                                                                          7, 7, 0, 0,
                                                                          0, 7, 0, 0]),
                                   Grid(size: BlockTemplate.size, array: [0, 7, 7, 0,
                                                                          7, 7, 0, 0])]

    private static let size = Size(width: 4, height: 4)

}
