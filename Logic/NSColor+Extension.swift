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
        let comps = [self.rgbComponents.map { $0 * 0.5 }, [self.alphaComponent]].flatMap { $0 }
        return NSColor(red: comps[0], green: comps[1], blue: comps[2], alpha: comps[3])
    }

    var rgbComponents: [CGFloat] {
        return [self.redComponent, self.greenComponent, self.blueComponent]
    }

}
