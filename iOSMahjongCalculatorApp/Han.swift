//
//  Han.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 12/16/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import Foundation

public class Han {
    
    var count:Double
    var wh:Hand
    
    init(wh:Hand) {
        self.count = 0
        self.wh = wh
    }
    
    func calculateHan() -> Double {
        self.count = 0
        calculateHanSequence()
        calculateHanTriplets()
        calculateHanTerminals()
        calculateHanSuit()
        if wh.sevenPairs() { count += 2 }
        calculateHanLuck()
        return self.count
    }
    
    func calculateHanLuck() {
        
        func calculateDora() {
            if count == 0 { return }
            var tilesToCheck:[Tile] = []
            for tile in wh.conditions.doraTiles {
                if (tile.value.rawValue == 9) {
                    let tile = Tile(value: Value(rawValue: 1)!, suit: tile.suit)
                    tilesToCheck.append(tile)
                } else if (tile.value.rawValue == 13) {
                    let tile = Tile(value: Value(rawValue: 10)!, suit: tile.suit)
                    tilesToCheck.append(tile)
                } else if (tile.value.rawValue == 16) {
                    let tile = Tile(value: Value(rawValue: 14)!, suit: tile.suit)
                    tilesToCheck.append(tile)
                } else {
                    let tile = Tile(value: Value(rawValue: tile.value.rawValue + 1)!, suit: tile.suit)
                    tilesToCheck.append(tile)
                }
            }
            for tileTC in tilesToCheck {
                for tileWH in wh.tiles {
                    if tileTC.isEqual(tileWH) {
                        count++
                    }
                }
            }
        }
        
        if wh.conditions.isRiichi() { count++ }
        if wh.conditions.isIppatsu() { count++ }
        if wh.conditions.isLastTileFromWall() { count++ }
        if wh.conditions.isLastDiscard() { count++ }
        if wh.conditions.isDeadWallDraw() { count++ }
        if wh.conditions.isRobKan() { count++ }
        if wh.conditions.isDoubleRiichi() { count += 2 }
        calculateDora()
    }
    
    func calculateHanSequence() {
        var melds:[Meld] = []
        for meld in wh.melds {
            if (meld.isSequence()) {
                melds.append(meld)
            }
        }
        
        func allSequence() {
            if !(wh.isClosed()) { return }
            if (melds.count == 4) { count++ }
        }
        
        func doubleSequence() {
            
            func doubleDoubleSequence(i:Int, j:Int) {
                if melds.count < 4 { return }
                
                var otherMelds:[Meld] = []
                for k in 0...(melds.count - 1) {
                    if k != i && k != j {
                        otherMelds.append(melds[k])
                    }
                }
                
                if otherMelds[0].isEqual(otherMelds[1]) {
                    count += 2
                }
            }
            
            for i in 0...(melds.count - 2){
                for j in i+1...(melds.count - 1) {
                    if wh.melds[i].isEqual(wh.melds[j]) {
                        count++
                        doubleDoubleSequence(i,j)
                        return
                    }
                }
            }
        }
        
        func straight() {
            var pinAcc = 0
            var souAcc = 0
            var wanAcc = 0
            
            for i in 1...9 {
                if wh.containsTile(Tile(value: Value(rawValue: i)!, suit: Suit.Pin)) {
                    pinAcc++
                }
                if wh.containsTile(Tile(value: Value(rawValue: i)!, suit: Suit.Sou)) {
                    souAcc++
                }
                if wh.containsTile(Tile(value: Value(rawValue: i)!, suit: Suit.Wan)) {
                    wanAcc++
                }
            }
            if (pinAcc == 9 || souAcc == 9 || wanAcc == 9) {
                if wh.isClosed() { count += 2 }
                else { count++ }
            }
        }
        
        func colourStraight() {
            var meldAcc1 = melds[0]
            var meldAcc2 = melds[1]
            var meldAcc3 = 0
            var meldAcc4 = 0
            
            for meld in melds {
                if (meld.tile1.value == meldAcc1.tile1.value &&
                    meld.tile1.suit != meldAcc1.tile1.suit) { ++meldAcc3 }
                if (meld.tile1.value == meldAcc2.tile1.value &&
                    meld.tile1.suit != meldAcc2.tile1.suit){ ++meldAcc4 }
            }
            if (meldAcc3 >= 2 || meldAcc4 >= 2) {
                if wh.isClosed() { count += 2 }
                else { count++ }
            }
        }
        
        if melds.count < 3 { return }
        allSequence()
        doubleSequence()
        straight()
        colourStraight()
    }
    
    func calculateHanTriplets() {
        var melds:[Meld] = []
        for meld in wh.melds {
            if (meld.isTriplet()) {
                melds.append(meld)
            }
        }
        if (melds.count <= 2) { return }
        
        var kanAcc = 0
        var closedAcc = 0
        var value1Acc = 0
        var value2Acc = 0
        var tile1 = melds[0].tile1
        var tile2 = melds[1].tile1
        
        for meld in melds {
            if (meld.isKan()) { ++kanAcc }
            if (meld.isClosed()) { ++closedAcc }
            if (meld.tile1.isEqual(tile1) && meld.tile1.suit != tile1.suit) { ++value1Acc }
            if (meld.tile1.isEqual(tile2) && meld.tile2.suit != tile2.suit) { ++value2Acc }
        }
        
        if kanAcc >= 3 { count += 2 }
        if closedAcc >= 3 { count += 2 }
        if (value1Acc >= 2 || value2Acc >= 2) { count += 2 }
        
    }
    
    func calculateHanTerminals() {
        func allTerminal() -> Bool {
            for meld in wh.melds {
                if !(meld.tile1.isTerminal() && meld.tile2.isTerminal() &&
                    meld.tile3.isTerminal()) { return false }
            }
            if !((wh.pair.tile1.isTerminal()) || (wh.pair.tile2.isTerminal())) {
                return false
            }
            return true
        }
        
        func allNonTerminalOrHonor() -> Bool {
            for meld in wh.melds {
                if (meld.tile1.isTerminalOrHonor() || meld.tile2.isTerminalOrHonor() ||
                    meld.tile3.isTerminalOrHonor()) { return false }
            }
            if (wh.pair.tile1.isTerminalOrHonor()) || (wh.pair.tile2.isTerminalOrHonor()) {
                return false
            }
            return true
        }
        
        func honourTriplets() {
            var dragonAcc:Double = 0
            
            for meld in wh.melds {
                if (meld.isTriplet()) &&
                ((meld.tile1.isCorrectWind(wh.conditions.seat)) ||
                (meld.tile1.isCorrectWind(wh.conditions.round))) {
                    count++
                }
                if meld.isTriplet() && (meld.tile1.suit == Suit.Dragon) {
                    count++
                    dragonAcc++
                }
            }
            if (dragonAcc == 2) && ((wh.pair.tile1.suit == Suit.Dragon) ||
                (wh.pair.tile1.isCorrectWind(wh.conditions.seat)) ||
                (wh.pair.tile1.isCorrectWind(wh.conditions.round))) {
                count += 2
            }
        }
        
        func terminalOrHonorInEachSet() {
            if !(wh.pair.tile1.isTerminalOrHonor()) { return }
            for meld in wh.melds {
                if !(meld.tile1.isTerminalOrHonor() || meld.tile3.isTerminalOrHonor()) { return }
            }
            if wh.isClosed() { count++ }
            for meld in wh.melds {
                if !(meld.tile1.isTerminal() || meld.tile3.isTerminal())
                { count++; return }
            }
            if !(wh.pair.tile1.isTerminal()) { count += 1; return }
            else { count += 2 }
        }
        
        if allTerminal() { count += 2 }
        if allNonTerminalOrHonor() { count++ }
        honourTriplets()
        terminalOrHonorInEachSet()
    }
    
    func calculateHanSuit() {
        var acc = Suit.Wind
        var i = 0
        while ((acc == Suit.Wind) || (acc == Suit.Dragon)) {
            acc = wh.tiles[i].suit
            i++
        }
        for tile in wh.tiles {
            if !(tile.suit == acc) && !(tile.isHonor()) {
                return
            }
        }
        if (wh.isClosed()) { count++ }
        for tile in wh.tiles {
            if !(tile.suit == acc) {
                count += 2
                return
            }
        }
        count += 5
    }
    
}