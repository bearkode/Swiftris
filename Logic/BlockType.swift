/*
 *  BlockType.swift
 *  Swiftris
 *
 *  Created by bearkode on 2016. 7. 28..
 *  Copyright © 2016 bearkode. All rights reserved.
 *
 */

import Foundation


internal enum BlockType: Int, CaseIterable {

    case box
    case bar
    case foldA
    case foldB
    case bump
    case zigzagA
    case zigzagB

}


extension BlockType {

    internal static func makeRandomType() -> BlockType {
        let index = self.makeRandomRawValue()
        return self.makeBlockType(with: index)
    }

    internal static func makeBlockType(with index: Int) -> BlockType {
        return BlockType(rawValue: index) ?? .bar
    }

    internal var grids: [Grid<Int>] {
        switch self {
        case .box:
            return BlockTemplate.box
        case .bar:
            return BlockTemplate.bar
        case .foldA:
            return BlockTemplate.foldA
        case .foldB:
            return BlockTemplate.foldB
        case .bump:
            return BlockTemplate.bump
        case .zigzagA:
            return BlockTemplate.zigzagA
        case .zigzagB:
            return BlockTemplate.zigzagB
        }
    }

    private static func makeRandomRawValue() -> Int {
        return Int(arc4random()) % (self.allCases.count + 1)
    }

}
