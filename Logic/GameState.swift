/*
 *  GameState.swift
 *  Swiftris
 *
 *  Created by bearkode on 2016. 7. 29..
 *  Copyright © 2016 bearkode. All rights reserved.
 *
 */

import Foundation


internal protocol GameState {

    var isStarted: Bool { get }
    var isResumed: Bool { get }

    var buttonTitle: String { get }
    var nextState: GameState { get }

}


extension GameState {

    internal var canHandleBlock: Bool {
        return self is PlayingState
    }

    internal var isPaused: Bool {
        return self is PauseState
    }

    internal var isGameOver: Bool {
        return self is GameOverState
    }

    internal var gameoverState: GameState {
        return GameOverState()
    }

}


internal struct ReadyState: GameState {

    internal private(set) var isStarted = false
    internal private(set) var isResumed = false

    internal private(set) var buttonTitle = "START"

    internal var nextState: GameState {
        return PlayingState(isStarted: true)
    }

}


internal struct PlayingState: GameState {

    internal private(set) var isStarted: Bool
    internal private(set) var isResumed: Bool

    internal private(set) var buttonTitle = "PAUSE"

    internal var nextState: GameState {
        return PauseState()
    }

    internal init(isStarted: Bool) {
        self.isStarted = isStarted
        self.isResumed = !self.isStarted
    }

}


internal struct PauseState: GameState {

    internal private(set) var isStarted = false
    internal private(set) var isResumed = false

    internal private(set) var buttonTitle: String = "RESUME"

    internal var nextState: GameState {
        return PlayingState(isStarted: false)
    }

    internal  init() {

    }

}


internal struct GameOverState: GameState {

    internal private(set) var isStarted = false
    internal private(set) var isResumed = false

    internal private(set) var buttonTitle = "START"

    internal var nextState: GameState {
        return ReadyState()
    }

    internal  init() {

    }

}
