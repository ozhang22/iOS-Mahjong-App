//
//  Tile.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 12/13/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import Foundation

public enum Suit: Int {
    case Wan = 1, Pin, Sou, Wind, Dragon
}

public enum Value: Int {
    case One = 1, Two, Three, Four, Five, Six, Seven, Eight, Nine
    case East = 10, South, West, North
    case White = 14, Green, Red
}

public enum Status: Int {
    case Chi = 1, Pon, Kan, ClosedKan, None
}

public class Tile {
    
    var value:Value
    var suit:Suit
    var status:Status
    var wait:Bool
    
    init(value:Value, suit:Suit) {
        self.value = value
        self.suit = suit
        self.status = Status.None
        self.wait = false
    }
    
    func getRawValue() -> Int {
        return status.rawValue*100 + suit.rawValue*10 + value.rawValue
    }
    
    func isEqual(other:Tile) -> Bool {
        return getRawValue() % 100 == other.getRawValue() % 100
    }
    
    func isEqualValueOnly(other:Tile) -> Bool {
        return value == other.value && suit != other.suit
    }
    
    func isGreaterThan(other:Tile) -> Bool {
        return getRawValue() > other.getRawValue()
    }
    
    func isOneValueGreaterThan(other:Tile) -> Bool {
        return value.rawValue + 1 == other.value.rawValue
    }
    
    func isSameSuit(other:Tile) -> Bool {
        return suit == other.suit
    }
    
    func hasSameStatus(other:Tile) -> Bool {
        return status == other.status
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
    
    func isCorrectWind(wind1:Wind) -> Bool {
        return (value.rawValue == wind1.rawValue)
    }
    
    func setStatus(status:Status) {
        self.status = status
    }
    
    func setWait(bool:Bool) {
        self.wait = bool
    }

}