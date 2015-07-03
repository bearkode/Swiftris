/*
 *  DropTimer.swift
 *  Swiftris
 *
 *  Created by bearkode on 2015. 7. 3..
 *  Copyright © 2015 bearkode. All rights reserved.
 *
 */

import Foundation


class DropTimer {

    init() {
        self.currentvalue = initValue
    }
    
    func isTimeToDrop() -> Bool {
        if self.currentvalue-- > 0 {
            return false
        }
        
        self.currentvalue = self.initValue

        return true
    }

    private let initValue = 5
    private var currentvalue: Int
    
}