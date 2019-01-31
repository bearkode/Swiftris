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

    // MARK: - init

    init(initValue: Int = 5) {
        self.initValue = initValue
        self.currentValue = initValue
    }

    // MARK: - internal

    mutating func isFired() -> Bool {
        if self.currentValue <= self.fireValue {
            self.currentValue = self.initValue
            return true
        }

        self.currentValue -= 1
        return false
    }

    // MARK: - private

    private let initValue: Int
    private let fireValue: Int = 0
    private var currentValue: Int

}
