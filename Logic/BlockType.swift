/*
 *  BlockType.swift
 *  Swiftris
 *
 *  Created by bearkode on 2016. 7. 28..
 *  Copyright © 2016 bearkode. All rights reserved.
 *
 */

import Foundation


internal enum BlockType: Int {

    case box
    case bar
    case foldA
    case foldB
    case bump
    case zigzagA
    case zigzagB

}


extension BlockType {

    internal static let allTypes: Set<BlockType> = [.box, .bar, .foldA, .foldB, .bump, .zigzagA, .zigzagB]

    internal static var randomType: BlockType {
        let index = Int(arc4random() % UInt32(self.zigzagB.rawValue + 1))

        return BlockType(rawValue: index) ?? .bar
    }

    internal var grids: [Grid] {
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

}
