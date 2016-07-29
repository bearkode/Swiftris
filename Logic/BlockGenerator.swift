/*
 *  BlockGenerator.swift
 *  Swiftris
 *
 *  Created by bearkode on 2016. 7. 28..
 *  Copyright © 2016 bearkode. All rights reserved.
 *
 */

import Foundation


class BlockGenerator {
    
    static let sharedGenerator = BlockGenerator()
    
    private init() {
        self.nextBlock = Block(type: BlockType.randomType, position: Point())
    }

    private(set) var nextBlock: Block
    
    func block(withPosition position: Point) -> Block {
        let result = self.nextBlock
        
        result.position = position
        
        self.nextBlock = Block(type: BlockType.randomType, position: Point())
        
        return result
    }
    
}
