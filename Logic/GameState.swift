/*
 *  GameState.swift
 *  Swiftris
 *
 *  Created by bearkode on 2016. 7. 29..
 *  Copyright © 2016 bearkode. All rights reserved.
 *
 */

import Foundation


class GameState {
    
    let prevState: GameState?
    
    init(prevState: GameState?) {
        self.prevState = prevState
    }
    
    var buttonTitle: String {
        return ""
    }
    
    var stateForStartButtonClick: GameState {
        return GameState(prevState: self)
    }
    
    var isStarted: Bool {
        return false
    }
    
    var isResumed: Bool {
        return false
    }
    
    var isPaused: Bool {
        return false
    }
    
    var isGameOver: Bool {
        return self is GameOverState
    }
    
    var isNotPlaying: Bool {
        return true
    }
    
}


class ReadyState: GameState {

    override var buttonTitle: String {
        return "START"
    }

    override var stateForStartButtonClick: GameState {
        return PlayingState(prevState: self)
    }

    override var isNotPlaying: Bool {
        return true
    }

}


class PlayingState: GameState {

    override var buttonTitle: String {
        return "PAUSE"
    }

    override var stateForStartButtonClick: GameState {
        return PauseState(prevState: self)
    }

    override var isStarted: Bool {
        guard let prevState = self.prevState else {
            return false
        }
        
        return prevState.isNotPlaying
    }

    override var isResumed: Bool {
        return !self.isStarted
    }

    override var isNotPlaying: Bool {
        return false
    }

}


class PauseState: GameState {

    override var buttonTitle: String {
        return "RESUME"
    }

    override var stateForStartButtonClick: GameState {
        return PlayingState(prevState: self)
    }
    
    override var isPaused: Bool {
        return true
    }

    override var isNotPlaying: Bool {
        return false
    }

}


class GameOverState: GameState {

    override var buttonTitle: String {
        return "START"
    }

    override var stateForStartButtonClick: GameState {
        return PlayingState(prevState: self)
    }
    
    override var isGameOver: Bool {
        return true
    }

    override var isNotPlaying: Bool {
        return true
    }

}
