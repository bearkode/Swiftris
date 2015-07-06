/*
 *  BlockExtensions.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 25..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


private let globalBlockTypes: [Block.Type] = [BlockA.self, BlockB.self, BlockC.self, BlockD.self, BlockE.self, BlockF.self, BlockG.self];


extension Block {

    class func randomBlock(position: Point) -> Block {
        let block = globalBlockTypes[Int(arc4random() % 7)]()

        block.position = position

        return block
    }
    
    class func randomBlock() -> Block {
        return self.randomBlock(Point())
    }

}