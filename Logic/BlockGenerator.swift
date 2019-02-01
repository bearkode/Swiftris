/*
 *  BlockGenerator.swift
 *  Swiftris
 *
 *  Created by bearkode on 2016. 7. 28..
 *  Copyright © 2016 bearkode. All rights reserved.
 *
 */

import Foundation


internal class BlockGenerator {

    // MARK: - singleton

    internal static let sharedGenerator = BlockGenerator()

    private init() {
        self.nextBlock = Block(type: BlockType.makeRandomType(), position: Point())
    }

    // MARK: - internal

    internal private(set) var nextBlock: Block

    internal func block(withPosition position: Point) -> Block {
        let result = self.nextBlock

        result.position = position

        self.nextBlock = Block(type: BlockType.makeRandomType(), position: Point())

        return result
    }

}
