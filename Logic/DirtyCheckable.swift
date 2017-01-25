/*
 *  DirtyCheckable.swift
 *  Swiftris
 *
 *  Created by bearkode on 2017. 1. 24..
 *  Copyright © 2017 bearkode. All rights reserved.
 *
 */

import Foundation


protocol DirtyCheckable: class {

    var dirty: Bool { set get }

}


extension Sequence where Iterator.Element == DirtyCheckable {
    
    func checkDirty(_ dirtyHandler: () -> Void) {
        if self.isDirty {
            dirtyHandler()
            self.resetDirty()
        }
    }
    
    var isDirty: Bool {
        return self.reduce(true) {
            return $0 ? $1.dirty : false
        }
    }

    func resetDirty() {
        self.forEach {
            $0.dirty = false
        }
    }

}

