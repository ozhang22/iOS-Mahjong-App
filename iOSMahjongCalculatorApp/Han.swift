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
        if wh.sevenPairs() {
            count += 2
            println("seven pairs han +2")
        }
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
                        println("dora han +1")
                    }
                }
            }
        }
        
        if wh.conditions.isRiichi() {
            count++
            println("riichi han +1")
        }
        if wh.conditions.isIppatsu() {
            count++
            println("ippatsu han +1")
        }
        if wh.conditions.isLastTileFromWall() {
            count++
            println("last tile from wall han +1")
        }
        if wh.conditions.isLastDiscard() {
            count++
            println("last discard han +1")
        }
        if wh.conditions.isDeadWallDraw() {
            count++
            println("dead wall draw han +1")
        }
        if wh.conditions.isRobKan() {
            count++
            println("rob Kan han +1")
        }
        if wh.conditions.isDoubleRiichi() {
            count++
            println("double riichi han +1")
        }
        if wh.isClosed() && wh.conditions.isTsumo() {
            count++
            println("closed tsumo han +1")
        }
        
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
            if (wh.isClosed() && (melds.count == 4)) {
                count++
                println("allSequence han +1")
            }
        }
        
        func doubleSequence() {
            
            func doubleDoubleSequence(i:Int, j:Int) {
                if melds.count < 4 {
                    return
                }
                
                var otherMelds:[Meld] = []
                for k in 0...(melds.count - 1) {
                    if k != i && k != j {
                        otherMelds.append(melds[k])
                    }
                }
                
                if otherMelds[0].isEqual(otherMelds[1]) {
                    count += 2
                    println("doubleDoubleSequence han +2")
                }
            }
            
            for i in 0...(melds.count - 2){
                for j in i+1...(melds.count - 1) {
                    if wh.melds[i].isEqual(wh.melds[j]) {
                        count++
                        println("singleDoubleSequence han +1")
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
                count++
                println("straight han +1")
                if wh.isClosed() {
                    count++
                    println("closed straight han +1")
                }
                
            }
        }
        
        func colourStraight() {
            var meldAcc1 = melds[0]
            var meldAcc2 = melds[1]
            var meldAcc3 = 0
            var meldAcc4 = 0
            
            for meld in melds {
                if (meld.tile1.value == meldAcc1.tile1.value &&
                    meld.tile1.suit != meldAcc1.tile1.suit) {
                        ++meldAcc3
                }
                if (meld.tile1.value == meldAcc2.tile1.value &&
                    meld.tile1.suit != meldAcc2.tile1.suit){
                        ++meldAcc4
                }
            }
            if (meldAcc3 >= 2 || meldAcc4 >= 2) {
                count++
                println("colour straight han +1")
                if wh.isClosed() {
                    count++
                    println("closed colour straight han +1")
                }
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
        if (melds.count <= 2) {
            return
        }
        
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
        
        if kanAcc >= 3 {
            count += 2
            println(">3 kans han +2")
        }
        if closedAcc >= 3 {
            count += 2
            println(">3 closed triplets/kan han +2")
        }
        if (value1Acc >= 2 || value2Acc >= 2) {
            count += 2
            println("3 triplets same value han +2")
        }
        
    }
    
    func calculateHanTerminals() {
        func allTerminal() -> Bool {
            for meld in wh.melds {
                if !(meld.tile1.isTerminal() && meld.tile2.isTerminal() &&
                    meld.tile3.isTerminal()) {
                        return false
                }
            }
            if !((wh.pair.tile1.isTerminal()) || (wh.pair.tile2.isTerminal())) {
                return false
            }
            return true
        }
        
        func allNonTerminalOrHonor() -> Bool {
            for meld in wh.melds {
                if (meld.tile1.isTerminalOrHonor() || meld.tile2.isTerminalOrHonor() ||
                    meld.tile3.isTerminalOrHonor()) {
                        return false
                }
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
                    println("same wind as seat/round triplet han +1")
                }
                if meld.isTriplet() && (meld.tile1.suit == Suit.Dragon) {
                    count++
                    println("dragon triplet han +1")
                    dragonAcc++
                }
            }
            if (dragonAcc == 2) && ((wh.pair.tile1.suit == Suit.Dragon) ||
                (wh.pair.tile1.isCorrectWind(wh.conditions.seat)) ||
                (wh.pair.tile1.isCorrectWind(wh.conditions.round))) {
                    count += 2
                    println("little dragons han +2")
            }
        }
        
        func terminalOrHonorInEachSet() {
            if !(wh.pair.tile1.isTerminalOrHonor()) {
                return
            }
            for meld in wh.melds {
                if !(meld.tile1.isTerminalOrHonor() || meld.tile3.isTerminalOrHonor()) {
                    return
                }
            }
            if wh.isClosed() {
                count++
                println("all sets have terminals or honours closed han +1")
            }
            for meld in wh.melds {
                if !(meld.tile1.isTerminal() || meld.tile3.isTerminal()) {
                    count++
                    println("sets have mixed terminals and honours han +1")
                    return
                }
            }
            if !(wh.pair.tile1.isTerminal()) {
                count++
                println("sets have mixed terminals and honours han +1")
            }
            else {
                count += 2
                println("all sets have terminals han +2")
            }
        }
        
        if allTerminal() {
            count += 2
            println("all hand of terminals han +2")
        }
        if allNonTerminalOrHonor() {
            count++
            println("no terminals or honours han +1")
        }
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
        if (wh.isClosed()) {
            count++
            println("mixed/pure closed flush han +1")
        }
        for tile in wh.tiles {
            if !(tile.suit == acc) {
                count += 2
                println("mixed flush han +2")
                return
            }
        }
        count += 5
        println("pure flush han +2")
    }
    
}