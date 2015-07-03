/*
 *  DropTimer.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 3..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import Foundation


struct DropTimer {

    let initValue = 5
    var currentvalue: Int
    
    init() {
        self.currentvalue = initValue
    }
    
    mutating func isTimeToDrop() -> Bool {
        if self.currentvalue-- > 0 {
            return false
        }
        
        self.currentvalue = self.initValue

        return true
    }
    
}