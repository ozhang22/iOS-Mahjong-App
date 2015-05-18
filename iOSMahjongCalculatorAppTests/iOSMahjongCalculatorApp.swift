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
        
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Two, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Three, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Five, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.White, suit: Suit.Dragon))
        winningHand.addTile(Tile(value: Value.White, suit: Suit.Dragon))
        winningHand.tiles[0].changeWait()
        winningHand.melds[0].setClosed(true)
        winningHand.conditions.addDoraTile(Tile(value: Value.Nine, suit: Suit.Sou))
        
        XCTAssertEqual(winningHand.calculateScore().basicPoints, 480, "fail")
    }
    
    func testFlush() {
        let winningHand = Hand()
        
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Two, suit: Suit.Sou))
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
        winningHand.tiles[1].changeWait()
        winningHand.melds[0].setClosed(true)
        winningHand.melds[1].setClosed(true)
        winningHand.melds[2].setClosed(true)
        winningHand.melds[3].setClosed(true)
        winningHand.conditions.addDoraTile(Tile(value: Value.Seven, suit: Suit.Wan))
        winningHand.conditions.addDoraTile(Tile(value: Value.Red, suit: Suit.Dragon))
        
        XCTAssertEqual(winningHand.calculateScore().basicPoints, 3000, "fail")
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
        winningHand.tiles[10].changeWait()
        winningHand.melds[0].setClosed(true)
        winningHand.melds[2].setClosed(true)
        winningHand.melds[3].setClosed(true)
        winningHand.conditions.setDealer(true)
        winningHand.conditions.addDoraTile(Tile(value: Value.Four, suit: Suit.Wan))
        
        XCTAssertEqual(winningHand.calculateScore().basicPoints, 960, "fail")
    }
    
    func testInvalidTriplets() {
        let winningHand = Hand()
        
        winningHand.addTile(Tile(value: Value.Five, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Green, suit: Suit.Dragon))
        winningHand.addTile(Tile(value: Value.Green, suit: Suit.Dragon))
        winningHand.tiles[1].changeWait()
        winningHand.melds[0].setClosed(true)
        winningHand.melds[2].setClosed(true)
        winningHand.melds[3].setClosed(true)
        winningHand.conditions.setSeat(Wind.South)
        winningHand.conditions.addDoraTile(Tile(value: Value.Three, suit: Suit.Wan))
        
        XCTAssertEqual(winningHand.calculateScore().basicPoints, 0, "fail")
    }
    
    func testclosedTripletsTwoKan() {
        let winningHand = Hand()
        
        winningHand.addTile(Tile(value: Value.Five, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Two, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Two, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Two, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Wan))
        winningHand.tiles[1].changeWait()
        winningHand.melds[1].setKan(true)
        winningHand.melds[3].setKan(true)
        winningHand.melds[1].setClosed(true)
        winningHand.melds[2].setClosed(true)
        winningHand.melds[3].setClosed(true)
        winningHand.conditions.setSeat(Wind.South)
        winningHand.conditions.addDoraTile(Tile(value: Value.Three, suit: Suit.Wan))
        winningHand.conditions.addDoraTile(Tile(value: Value.Five, suit: Suit.Wan))
        
        XCTAssertEqual(winningHand.calculateScore().basicPoints, 4000, "fail")
    }
    
    func testThreeColourStraightandNonTerminal() {
        let winningHand = Hand()
        
        winningHand.addTile(Tile(value: Value.Two, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Three, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Five, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Two, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Three, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Two, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Three, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Wan))
        winningHand.tiles[13].changeWait()
        winningHand.melds[2].setClosed(true)
        winningHand.melds[3].setClosed(true)
        winningHand.conditions.setRiichi(true, hand: winningHand)
        winningHand.conditions.addDoraTile(Tile(value: Value.North, suit: Suit.Wind))
        
        XCTAssertEqual(winningHand.calculateScore().basicPoints, 480, "fail")
    }
    
    func testNotStraightNoHan() {
        let winningHand = Hand()
        
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Two, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Three, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Five, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Four, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Five, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Six, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.East, suit: Suit.Wind))
        winningHand.addTile(Tile(value: Value.East, suit: Suit.Wind))
        winningHand.tiles[13].changeWait()
        winningHand.conditions.addDoraTile(Tile(value: Value.North, suit: Suit.Wind))
        
        XCTAssertEqual(winningHand.calculateScore().basicPoints, 0, "fail")
    }
    
    func testAllTerminal() {
        let winningHand = Hand()
        
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Pin))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.One, suit: Suit.Wan))
        winningHand.addTile(Tile(value: Value.Seven, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Nine, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.East, suit: Suit.Wind))
        winningHand.addTile(Tile(value: Value.East, suit: Suit.Wind))
        winningHand.tiles[7].changeWait()
        winningHand.melds[2].setClosed(true)
        winningHand.melds[3].setClosed(true)
        winningHand.conditions.setTsumo(true)
        winningHand.conditions.addDoraTile(Tile(value: Value.South, suit: Suit.Wind))
        
        XCTAssertEqual(winningHand.calculateScore().basicPoints, 640, "fail")
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
        winningHand.addTile(Tile(value: Value.Three, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Three, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Eight, suit: Suit.Sou))
        winningHand.addTile(Tile(value: Value.Red, suit: Suit.Dragon))
        winningHand.addTile(Tile(value: Value.Red, suit: Suit.Dragon))
        winningHand.tiles[9].changeWait()
        winningHand.conditions.setRiichi(true, hand: winningHand)
        winningHand.conditions.setTsumo(true)
        winningHand.conditions.addDoraTile(Tile(value: Value.South, suit: Suit.Wind))
        
        XCTAssertEqual(winningHand.calculateScore().basicPoints, 800, "fail")
    }

}
