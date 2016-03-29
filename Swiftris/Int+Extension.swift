/*
 *  IntExtension.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 7. 3..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Foundation


extension Int {

    var exist: Bool {
        return (self != 0) ? true : false
    }
    
    var empty: Bool {
        return (self == 0) ? true : false
    }
    
}