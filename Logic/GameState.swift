/*
 *  GameState.swift
 *  Swiftris
 *
 *  Created by bearkode on 2016. 7. 29..
 *  Copyright © 2016 bearkode. All rights reserved.
 *
 */

import Foundation


protocol GameState {

    var isStarted: Bool { get }
    var isResumed: Bool { get }

    var buttonTitle: String { get }
    var nextState: GameState { get }

}


extension GameState {

    var isPaused: Bool {
        return self is PauseState
    }

    var isGameOver: Bool {
        return self is GameOverState
    }

    var gameoverState: GameState {
        return GameOverState()
    }

}


struct ReadyState: GameState {

    private(set) var isStarted = false
    private(set) var isResumed = false

    private(set) var buttonTitle = "START"

    var nextState: GameState {
        return PlayingState(isStarted: true)
    }

}


struct PlayingState: GameState {

    private(set) var isStarted: Bool
    private(set) var isResumed: Bool

    private(set) var buttonTitle = "PAUSE"

    var nextState: GameState {
        return PauseState()
    }

    fileprivate init(isStarted: Bool) {
        self.isStarted = isStarted
        self.isResumed = !self.isStarted
    }

}


struct PauseState: GameState {

    private(set) var isStarted = false
    private(set) var isResumed = false

    private(set) var buttonTitle: String = "RESUME"

    var nextState: GameState {
        return PlayingState(isStarted: false)
    }

    fileprivate init() {

    }

}


struct GameOverState: GameState {

    private(set) var isStarted = false
    private(set) var isResumed = false

    private(set) var buttonTitle = "START"

    var nextState: GameState {
        return ReadyState()
    }

    fileprivate init() {

    }

}
