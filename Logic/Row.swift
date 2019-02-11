//
//  Row.swift
//  Logic
//
//  Created by bearkode on 08/02/2019.
//  Copyright © 2019 bearkode. All rights reserved.
//

import Foundation


internal struct Row<T> {

    internal init(index: Int, buffer: [T?]) {
        self.index = index
        self.buffer = buffer
    }

    internal var isEmpty: Bool {
        return self.buffer.compactMap { $0 }.isEmpty
    }

    internal var isFull: Bool {
        return self.buffer.compactMap { $0 }.count == self.buffer.count
    }

    internal var index: Int
    internal var buffer: [T?]

}
