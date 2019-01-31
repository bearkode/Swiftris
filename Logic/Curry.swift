//
//  Curry.swift
//  Logic
//
//  Created by bearkode on 31/01/2019.
//  Copyright © 2019 bearkode. All rights reserved.
//

import Foundation


func curry<A, B, C, D, E>(_ f: @escaping (A, B, C, D) -> E) -> (A) -> (B) -> (C) -> (D) -> E {
    return { a in { b in { c in { d in f(a, b, c, d) } } } }
}
