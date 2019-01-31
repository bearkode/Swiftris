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

    internal var isExist: Bool {
        return (self != 0) ? true : false
    }

    internal var isEmpty: Bool {
        return (self == 0) ? true : false
    }

}
