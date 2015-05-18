//
//  Tile.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 12/13/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import Foundation

public enum Suit: Int {
    case Pin = 1, Sou, Wan, Wind, Dragon
}

public enum Value: Int {
    case One = 1, Two, Three, Four, Five, Six, Seven, Eight, Nine
    case East = 10, South, West, North
    case Red = 14, Green, White
}

public class Tile {
    
    var value:Value
    var suit:Suit
    var wait:Bool
    
    init(value:Value, suit:Suit) {
        self.value = value
        self.suit = suit
        wait = false
    }
    
    func getRawValue() -> Int {
        return suit.rawValue*10 + value.rawValue
    }
    
    func isEqual(other:Tile) -> Bool {
        return getRawValue() == other.getRawValue()
    }
    
    func isTerminal() -> Bool {
        return (value.rawValue == 1) || (value.rawValue == 9)
    }
    
    func isHonor() -> Bool {
        return suit.rawValue > 3
    }
    
    func isTerminalOrHonor() -> Bool {
        return isTerminal() || isHonor() 
    }
    
    func isCorrectWind(wind:Wind) -> Bool {
        return suit.rawValue == wind.rawValue
    }
    
    func changeWait() {
        self.wait = !self.wait
    }
}