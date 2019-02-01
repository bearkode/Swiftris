/*
 *  DirtyCheckable.swift
 *  Swiftris
 *
 *  Created by bearkode on 2017. 1. 24..
 *  Copyright © 2017 bearkode. All rights reserved.
 *
 */

import Foundation


internal protocol DirtyCheckable: AnyObject {

    var dirty: Bool { get set }

}


extension Sequence where Iterator.Element == DirtyCheckable {

    internal func checkDirty(_ dirtyHandler: () -> Void) {
        guard self.isDirty == true else {
            return
        }

        dirtyHandler()
        self.resetDirty()
    }

    internal var isDirty: Bool {
        return (self.filter { $0.dirty }.isEmpty) ? false : true
    }

    internal func resetDirty() {
        self.forEach { $0.dirty = false }
    }

}
