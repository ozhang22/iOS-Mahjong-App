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
        return value == Value.One || value == Value.Nine
    }
    
    func isHonor() -> Bool {
        return suit == Suit.Wind || suit == Suit.Dragon
    }
    
    func isTerminalOrHonor() -> Bool {
        return isTerminal() || isHonor() 
    }
    
    func isDragon() -> Bool {
        return suit == Suit.Dragon
    }
    
    func isCorrectWind(wind1:Wind, wind2:Wind) -> Bool {
        return suit.rawValue == wind1.rawValue || suit.rawValue == wind2.rawValue
    }
    
    func changeWait() {
        self.wait = !self.wait
    }
}