/*
 *  BlockExtensions.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 25..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


let blockClasses: Block.Type[] = [BlockA.self, BlockB.self, BlockC.self, BlockD.self, BlockE.self, BlockF.self, BlockG.self];


extension Block {

    class func randomBlock() -> Block! {
        let blockClass = blockClasses[Int(arc4random() % 7)]
        return blockClass()
    }

}