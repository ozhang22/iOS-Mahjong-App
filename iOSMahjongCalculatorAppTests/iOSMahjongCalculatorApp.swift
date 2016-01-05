//
//  iOSMahjongCalculatorTests.swift
//  iOSMahjongCalculatorTests
//
//  Created by Oliver Zhang on 12/13/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import UIKit
import XCTest

class iOSMahjongCalculatorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

    func testStraight() {
        let winningHand = Hand()

        winningHand.addMeld(Tile(value: Value.Four, suit: Suit.Sou), status: .Chi)
        winningHand.addMeld(Tile(value: Value.Seven, suit: Suit.Sou), status: .Chi)
        winningHand.addTile(Tile(value: Value.Two, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Three, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.White, suit: Suit.Dragon))
        winningHand.addTile(Tile(value: Value.White, suit: Suit.Dragon))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Sou)) // wait
        winningHand.conditions.addDoraTile(Tile(value: Value.Nine, suit: Suit.Sou))
        winningHand.calculateScore()
        
        XCTAssertEqual(winningHand.basicPoints, 480, "fail")
    }

    func testFlush() {
        let winningHand = Hand()
        
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Three, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Five, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Five, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Two, suit: Suit.Sou)) // wait
        winningHand.conditions.addDoraTile(Tile(value: Value.Seven, suit: Suit.Wan))
        winningHand.conditions.addDoraTile(Tile(value: Value.Red, suit: Suit.Dragon))
        winningHand.calculateScore()
        
        XCTAssertEqual(winningHand.basicPoints, 3000, "fail")
    }

    func testDoubleSequence() {
        let winningHand = Hand()
        
        winningHand.addTile(Tile(value: Value.Five, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.North, suit: Suit.Wind))
        winningHand.addTile(Tile(value: Value.North, suit: Suit.Wind))
        winningHand.addTile(Tile(value: Value.North, suit: Suit.Wind))
        winningHand.addTile(Tile(value: Value.Five, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Five, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Pin))
        winningHand.conditions.addDoraTile(Tile(value: Value.Four, suit: Suit.Wan))
        winningHand.conditions.setSeat(Wind.North)
        winningHand.calculateScore()

        XCTAssertEqual(winningHand.basicPoints, 2000, "fail")
    }

    func testInvalidTriplets() {
        let winningHand = Hand()
        
        winningHand.addMeld(Tile(value: Value.Four, suit: Suit.Wan), status: .Pon)
        winningHand.addTile(Tile(value: Value.Five, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Green, suit: Suit.Dragon))
        winningHand.addTile(Tile(value: Value.Green, suit: Suit.Dragon))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Pin)) // wait
        winningHand.conditions.setSeat(Wind.South)
        winningHand.conditions.addDoraTile(Tile(value: Value.Three, suit: Suit.Wan))
        winningHand.calculateScore()
        
        XCTAssertEqual(winningHand.basicPoints, 0, "fail")
    }

    func testclosedTripletsTwoKan() {
        let winningHand = Hand()
        
        winningHand.addTile(Tile(value: Value.Five, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Pin))
        winningHand.addMeld(Tile(value: Value.Two, suit: Suit.Wan), status: .ClosedKan)
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Wan))
        winningHand.addMeld(Tile(value: Value.Eight, suit: Suit.Sou), status: .ClosedKan)
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Wan)) // wait
        winningHand.conditions.setSeat(Wind.South)
        winningHand.conditions.addDoraTile(Tile(value: Value.Three, suit: Suit.Wan))
        winningHand.conditions.addDoraTile(Tile(value: Value.Five, suit: Suit.Wan))
        winningHand.calculateScore()
        
        XCTAssertEqual(winningHand.basicPoints, 3000, "fail")
    }

    func testThreeColourStraightandNonTerminal() {
        let winningHand = Hand()
        
        winningHand.addMeld(Tile(value: Value.Two, suit: Suit.Pin), status: .Chi)
        winningHand.addMeld(Tile(value: Value.Five, suit: Suit.Wan), status: .Chi)
        winningHand.addTile(Tile(value: Value.Two, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Two, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Three, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Three, suit: Suit.Wan)) // wait
        winningHand.conditions.addDoraTile(Tile(value: Value.North, suit: Suit.Wind))
        winningHand.calculateScore()
        
        XCTAssertEqual(winningHand.basicPoints, 480, "fail")
    }

    func testNotStraightNoHan() {
        let winningHand = Hand()
        
        winningHand.addMeld(Tile(value: Value.One, suit: Suit.Pin), status: .Chi)
        winningHand.addMeld(Tile(value: Value.Four, suit: Suit.Pin), status: .Chi)
        winningHand.addMeld(Tile(value: Value.Four, suit: Suit.Wan), status: .Chi)
        winningHand.addMeld(Tile(value: Value.Seven, suit: Suit.Wan), status: .Chi)
        winningHand.addTile(Tile(value: Value.East, suit: Suit.Wind))
        winningHand.addTile(Tile(value: Value.East, suit: Suit.Wind)) // wait
        winningHand.conditions.addDoraTile(Tile(value: Value.North, suit: Suit.Wind))
        winningHand.calculateScore()
        
        XCTAssertEqual(winningHand.basicPoints, 0, "fail")
    }

    func testAllTerminal() {
        let winningHand = Hand()
        
        winningHand.addMeld(Tile(value: Value.Seven, suit: Suit.Pin), status: .Chi)
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Wan))
        winningHand.addMeld(Tile(value: Value.Seven, suit: Suit.Sou), status: .Chi)
        winningHand.addTile(Tile(value: Value.East, suit: Suit.Wind))
        winningHand.addTile(Tile(value: Value.East, suit: Suit.Wind))
        winningHand.conditions.setTsumo(true)
        winningHand.conditions.addDoraTile(Tile(value: Value.South, suit: Suit.Wind))
        winningHand.calculateScore()
        
        XCTAssertEqual(winningHand.basicPoints, 640, "fail")
    }

    func testSevenPairs() {
        let winningHand = Hand()
        
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Red, suit: Suit.Dragon))
        winningHand.addTile(Tile(value: Value.Red, suit: Suit.Dragon))
        winningHand.addTile(Tile(value: Value.Three, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Three, suit: Suit.Sou))
        winningHand.conditions.setRiichi(true, hand: winningHand)
        winningHand.conditions.setTsumo(true)
        winningHand.conditions.addDoraTile(Tile(value: Value.South, suit: Suit.Wind))
        winningHand.calculateScore()
        
        XCTAssertEqual(winningHand.basicPoints, 1600, "fail")
    }

}
