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
        self.currentValue = initValue
    }
    
    func isTimeToDrop() -> Bool {
        if self.currentValue-- > 0 {
            return false
        }
        
        self.currentValue = self.initValue

        return true
    }

    private let initValue = 5
    private var currentValue: Int
    
}