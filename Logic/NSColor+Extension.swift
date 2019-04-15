/*
 *  NSColorExtension.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 24..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa


private let globalColorDict: [Int: NSColor] = [
    0: NSColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0),
    1: NSColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0),
    2: NSColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0),
    3: NSColor(red: 0.5, green: 1.0, blue: 0.0, alpha: 1.0),
    4: NSColor(red: 1.0, green: 0.0, blue: 0.5, alpha: 1.0),
    5: NSColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0),
    6: NSColor(red: 0.5, green: 0.0, blue: 1.0, alpha: 1.0),
    7: NSColor(red: 0.5, green: 1.0, blue: 1.0, alpha: 1.0)
]


extension NSColor {

    public class func color(forIndex index: Int) -> NSColor {
        return globalColorDict[index] ?? NSColor(calibratedRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

    public func halftone() -> NSColor {
        let comps = [self.rgbComponents.map { $0 / 2 }, [self.alphaComponent]].flatMap { $0 }
        return apply(f: curry(NSColor.init(red:green:blue:alpha:)), args: comps)
    }

    internal var rgbComponents: [CGFloat] {
        return [self.redComponent, self.greenComponent, self.blueComponent]
    }

}


internal func apply<A, B>(f: (A) -> (A) -> (A) -> (A) -> B, args: [A]) -> B {
    assert(args.count == 4)
    return f(args[0])(args[1])(args[2])(args[3])
}
