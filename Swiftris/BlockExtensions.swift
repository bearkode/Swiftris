/*
 *  BlockExtensions.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 25..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


extension Block {

    class func randomBlock() -> Block! {
        switch Int(arc4random() % 7) {
        case 0:
            return BlockA()
        case 1:
            return BlockB()
        case 2:
            return BlockC()
        case 3:
            return BlockD()
        case 4:
            return BlockE()
        case 5:
            return BlockF()
        case 6:
            return BlockG()
        default:
            return BlockA()
        }
    }

}