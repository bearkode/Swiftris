/*
 *  GameLogicController+Interface.swift
 *  Swiftris
 *
 *  Created by bearkode on 2016. 7. 29..
 *  Copyright © 2016 bearkode. All rights reserved.
 *
 */

import Foundation


extension GameLogicController {

    public func startButtonClicked() {
        switch self.state {
        case .ready:
            self.state = .playing
        case .playing:
            self.state = .pause
        case .pause:
            self.state = .playing
        case .gameOver:
            self.state = .playing
        }
    }
    
    public var startButtonTitle: String {
        switch self.state {
        case .ready:
            return "START"
        case .playing:
            return "PAUSE"
        case .pause:
            return "RESUME"
        case .gameOver:
            return "START"
        }
    }

}
