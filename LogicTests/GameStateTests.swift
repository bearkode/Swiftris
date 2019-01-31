/*
 *  GameStateTests.swift
 *  Swiftris
 *
 *  Created by bearkode on 2017. 6. 27..
 *  Copyright © 2017 bearkode. All rights reserved.
 *
 */

import XCTest
@testable import Logic


class GameStateTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testBasic() {
        var state: GameState = ReadyState()
        XCTAssertTrue(state is ReadyState)
        XCTAssertTrue(state.buttonTitle == "START")
        XCTAssertTrue(state.isStarted == false)
        XCTAssertTrue(state.isResumed == false)
        XCTAssertTrue(state.isPaused == false)
        XCTAssertTrue(state.isGameOver == false)

        state = state.nextState
        XCTAssertTrue(state is PlayingState)        
        XCTAssertTrue(state.buttonTitle == "PAUSE")
        XCTAssertTrue(state.isStarted == true)
        XCTAssertTrue(state.isResumed == false)
        XCTAssertTrue(state.isPaused == false)
        XCTAssertTrue(state.isGameOver == false)

        state = state.nextState
        XCTAssertTrue(state is PauseState)        
        XCTAssertTrue(state.buttonTitle == "RESUME")
        XCTAssertTrue(state.isStarted == false)
        XCTAssertTrue(state.isResumed == false)
        XCTAssertTrue(state.isPaused == true)
        XCTAssertTrue(state.isGameOver == false)

        state = state.nextState
        XCTAssertTrue(state is PlayingState)        
        XCTAssertTrue(state.buttonTitle == "PAUSE")
        XCTAssertTrue(state.isStarted == false)
        XCTAssertTrue(state.isResumed == true)
        XCTAssertTrue(state.isPaused == false)
        XCTAssertTrue(state.isGameOver == false)

        state = state.gameoverState
        XCTAssertTrue(state is GameOverState)
        XCTAssertTrue(state.buttonTitle == "START")
        XCTAssertTrue(state.isStarted == false)
        XCTAssertTrue(state.isResumed == false)
        XCTAssertTrue(state.isPaused == false)
        XCTAssertTrue(state.isGameOver == true)

        state = state.nextState
        XCTAssertTrue(state is ReadyState)
        XCTAssertTrue(state.buttonTitle == "START")
        XCTAssertTrue(state.isStarted == false)
        XCTAssertTrue(state.isResumed == false)
        XCTAssertTrue(state.isPaused == false)
        XCTAssertTrue(state.isGameOver == false)
    }

}
