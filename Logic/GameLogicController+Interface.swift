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
        self.state = self.state.stateForStartButtonClick
    }
    
    public var startButtonTitle: String {
        return self.state.buttonTitle
    }
    
}
