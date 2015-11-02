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
        if wh.sevenPairs() {
            self.count += 2
            wh.dictionary["Seven pairs"] = 2
            calculateOtherHanSevenPairs()
            return self.count
        }
        calculateHanSequence()
        calculateHanTriplets()
        calculateHanTerminals()
        calculateHanSuit()
        calculateHanLuck()
        return self.count
    }
    
    func calculateHanLuck() {
        
        func calculateDora() {
            if count == 0 {
                return
            }
            
            var tilesToCheck:[Tile] = []
            
            for tile in wh.conditions.doraTiles {
                if (tile.value == Value.Nine) {
                    let tile = Tile(value: Value.One, suit: tile.suit)
                    tilesToCheck.append(tile)
                } else if (tile.value == Value.North) {
                    let tile = Tile(value: Value.East, suit: tile.suit)
                    tilesToCheck.append(tile)
                } else if (tile.value == Value.Red) {
                    let tile = Tile(value: Value.White, suit: tile.suit)
                    tilesToCheck.append(tile)
                } else {
                    let tile = Tile(value: Value(rawValue: tile.value.rawValue + 1)!, suit: tile.suit)
                    tilesToCheck.append(tile)
                }
            }
            
            var i:Double = 0
            for tileTC in tilesToCheck {
                for tileWH in wh.tiles {
                    if tileTC.isEqual(tileWH) {
                        i++
                    }
                }
            }
            
            if i > 0 {
                count += i
                wh.dictionary["Dora"] = i
            }
        }
        
        if wh.conditions.isRiichi() {
            count++
            wh.dictionary["Riichi"] = 1
        }
        if wh.conditions.isIppatsu() {
            count++
            wh.dictionary["Ippatsu"] = 1
        }
        if wh.conditions.isLastTileFromWall() {
            count++
            wh.dictionary["Last tile from the wall"] = 1
        }
        if wh.conditions.isLastDiscard() {
            count++
            wh.dictionary["Last discard"] = 1
        }
        if wh.conditions.isDeadWallDraw() {
            count++
            wh.dictionary["Dead wall draw"] = 1
        }
        if wh.conditions.isRobKan() {
            count++
            wh.dictionary["Kan robbed"] = 1
        }
        if wh.conditions.isDoubleRiichi() {
            count++
            wh.dictionary["Double riichi"] = 1
        }
        if wh.isClosed() && wh.conditions.isTsumo() {
            count++
            wh.dictionary["Closed tsumo"] = 1
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
        
        if melds.count < 3 {
            return
        }
        
        func allSequence() {
            if (wh.isClosed() && (melds.count == 4)) {
                count++
                wh.dictionary["All sequence"] = 1
            }
        }
        
        func doubleSequence() {
            
            func doubleDoubleSequence(i:Int, j:Int) {
                if melds.count < 4 {
                    wh.dictionary["One set of identical sequences"] = 1
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
                    wh.dictionary["Two sets of identical sequences"] = 3
                } else {
                    wh.dictionary["One set of identical sequences"] = 1
                }
            }
            
            if !wh.isClosed() {
                return
            }
            
            for i in 0...(melds.count - 2){
                if melds[i].isEqual(melds[i+1]) {
                    count++
                    doubleDoubleSequence(i,i+1)
                    return
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
                var i:Double = 1
                if wh.isClosed() {
                    i++
                }
                count += i
                wh.dictionary["Straight"] = i
            }
        }
        
        func colourStraight() {
            var meldAcc1 = melds[0]
            var meldAcc2 = melds[1]
            var meldAcc3 = 0
            var meldAcc4 = 0
            
            for meld in melds {
                if (meld.tile1.isEqualValueOnly(meldAcc1.tile1)) {
                    ++meldAcc3
                }
                if (meld.tile1.isEqualValueOnly(meldAcc2.tile1)) {
                    ++meldAcc4
                }
            }
            if (meldAcc3 >= 2 || meldAcc4 >= 2) {
                var i:Double = 1
                if wh.isClosed() {
                    i++
                }
                count += i
                wh.dictionary["Three colour straight"] = i
            }
        }
        
        allSequence()
        doubleSequence()
        straight()
        colourStraight()
    }
    
    func calculateHanTriplets() {
        var melds:[Meld] = []
        for meld in wh.melds {
            if meld.isTriplet() {
                melds.append(meld)
            }
        }
        if melds.count <= 2 {
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
            if (meld.tile1.isEqualValueOnly(tile1)) { ++value1Acc }
            if (meld.tile1.isEqualValueOnly(tile2)) { ++value2Acc }
        }
        
        if kanAcc >= 3 {
            count += 2
            wh.dictionary["Three kans"] = 2
        }
        if closedAcc >= 3 {
            count += 2
            wh.dictionary["Three closed triplets or kans"] = 2
        }
        if value1Acc >= 2 || value2Acc >= 2 {
            count += 2
            wh.dictionary["Three colour triplets or kans"] = 2
        }
        if melds.count == 4 {
            count += 2
            wh.dictionary["All triplets or kans"] = 2
        }
    }
    
    func calculateHanTerminals() {
        func allTerminalAndHonor() -> Bool {
            for meld in wh.melds {
                if !(meld.tile1.isTerminalOrHonor() && meld.tile2.isTerminalOrHonor() &&
                    meld.tile3.isTerminalOrHonor()) {
                        return false
                }
            }
            return wh.pair.tile1.isTerminal()
        }
        
        func allNonTerminalOrHonor() -> Bool {
            for meld in wh.melds {
                if (meld.tile1.isTerminalOrHonor() || meld.tile2.isTerminalOrHonor() ||
                    meld.tile3.isTerminalOrHonor()) {
                        return false
                }
            }
            return !wh.pair.tile1.isTerminalOrHonor()
        }
        
        func honourTriplets() {
            var honour:Double = 0
            var dragonAcc:Double = 0

            for meld in wh.melds {
                if (meld.isTriplet()) &&
                    ((meld.tile1.isCorrectWind(wh.conditions.seat))) {
                    honour++
                }
                if (meld.isTriplet()) &&
                    ((meld.tile1.isCorrectWind(wh.conditions.round))) {
                        honour++
                }
                if meld.isTriplet() && (meld.tile1.isDragon()) {
                    honour++
                    dragonAcc++
                }
            }
            
            if honour > 0 {
                count += honour
                wh.dictionary["Honour tiles"] = honour
            }
            
            if (dragonAcc == 2) && ((wh.pair.tile1.isDragon())) {
                count += 2
                wh.dictionary["Little dragons"] = 2
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
            var i:Double = 0
            if wh.isClosed() {
                i++
            }
            for meld in wh.melds {
                if !(meld.tile1.isTerminal() || meld.tile3.isTerminal()) {
                    i++
                    count += i
                    wh.dictionary["Terminal or honor in each set"] = i
                    return
                }
            }
            if !(wh.pair.tile1.isTerminal()) {
                i++
                count += i
                wh.dictionary["Terminal or honor in each set"] = i
            }
            else {
                i += 2
                count += i
                wh.dictionary["Terminal in each set"] = i
            }
        }
        
        if allTerminalAndHonor() {
            count += 2
            wh.dictionary["All terminals and honours"] = 2
        }
        if allNonTerminalOrHonor() {
            count++
            wh.dictionary["All simples"] = 1
        }
        honourTriplets()
        terminalOrHonorInEachSet()
    }
    
    func calculateHanSuit() {
        var acc = wh.tiles[0].suit
        for tile in wh.tiles {
            if !(tile.suit == acc) && !(tile.isHonor()) {
                return
            }
        }
        var i:Double = 0
        if (wh.isClosed()) {
            i++
        }
        for tile in wh.tiles {
            if !(tile.suit == acc) {
                i += 2
                count += i
                wh.dictionary["Half-flush"] = i
                return
            }
        }
        
        i += 5
        count += i
        wh.dictionary["Flush"] = i
    }
    
    func calculateOtherHanSevenPairs() {
        func sevenPairsAllTerminalAndHonor() {
            for tile in wh.tiles {
                if !(tile.isTerminalOrHonor()) {
                    return
                }
            }
            
            self.count += 2
            wh.dictionary["All terminals and honours"] = 2
        }
        
        func sevenPairsAllNonTerminalOrHonor() {
            for tile in wh.tiles {
                if (tile.isTerminalOrHonor()) {
                    return
                }
            }
            
            self.count += 1
            wh.dictionary["All simples"] = 1
        }
        
        calculateHanSuit()
        calculateHanLuck()
        sevenPairsAllTerminalAndHonor()
        sevenPairsAllNonTerminalOrHonor()
    }
}