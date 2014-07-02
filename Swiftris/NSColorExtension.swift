/*
 *  NSColorExtension.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 24..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa


let globalColorDict: Dictionary<Int, NSColor> = [
    0 : NSColor(calibratedRed: 0.7, green: 0.7, blue: 0.7, alpha: 1.0),
    1 : NSColor(calibratedRed: 0.0, green: 0.5, blue: 1.0, alpha: 1.0),
    2 : NSColor(calibratedRed: 1.0, green: 0.5, blue: 0.0, alpha: 1.0),
    3 : NSColor(calibratedRed: 0.5, green: 1.0, blue: 0.0, alpha: 1.0),
    4 : NSColor(calibratedRed: 1.0, green: 0.0, blue: 0.5, alpha: 1.0),
    5 : NSColor(calibratedRed: 0.0, green: 1.0, blue: 0.5, alpha: 1.0),
    6 : NSColor(calibratedRed: 0.5, green: 0.0, blue: 1.0, alpha: 1.0),
    7 : NSColor(calibratedRed: 0.5, green: 1.0, blue: 1.0, alpha: 1.0),
]


extension NSColor {
    
    func halftone() -> NSColor {
        let factor = 0.5
        return NSColor(calibratedRed: redComponent * factor, green: greenComponent * factor, blue: blueComponent * factor, alpha: alphaComponent)
    }
    
    class func colorWithIndex(index: Int) -> NSColor! {
        if let result = globalColorDict[index] {
            return result
        } else {
            return NSColor(calibratedRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
}