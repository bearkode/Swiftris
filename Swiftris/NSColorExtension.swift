/*
 *  NSColorExtension.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 24..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa


extension NSColor {
    func halftone() -> NSColor {
        let factor = 0.5
        return NSColor(calibratedRed: redComponent * factor, green: greenComponent * factor, blue: blueComponent * factor, alpha: alphaComponent)
    }
}