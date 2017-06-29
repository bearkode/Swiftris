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

    init(initValue: Int = 5) {
        self.initValue = initValue
        self.currentValue = initValue
    }
    
    mutating func isFired() -> Bool {
        if self.currentValue <= self.fireValue {
            self.currentValue = self.initValue
            return true
        }
        
        self.currentValue -= 1
        return false
    }

    //  MARK: -
    private let initValue: Int
    private let fireValue: Int = 0
    private var currentValue: Int
    
}
