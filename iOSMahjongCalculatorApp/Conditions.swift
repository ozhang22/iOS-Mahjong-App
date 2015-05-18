//
//  Con.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 12/24/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import Foundation

public enum Wind: Int {
    case East = 10, South, West, North
}

public class Conditions {
    
    private var dealer:Bool
    var seat:Wind
    var round:Wind
    private var tsumo:Bool
    private var riichi:Bool
    private var ippatsu:Bool
    private var lastTileFromWall:Bool
    private var lastDiscard:Bool
    private var deadWallDraw:Bool
    private var robKan:Bool
    private var doubleRiichi:Bool
    var doraTiles:[Tile]
    
    init() {
        dealer = false
        seat = Wind.East
        round = Wind.East
        riichi = false
        tsumo = false
        ippatsu = false
        lastTileFromWall = false
        lastDiscard = false
        deadWallDraw = false
        robKan = false
        doubleRiichi = false
        doraTiles = []
    }
    
    func clearConditions() {
        dealer = false
        seat = Wind.East
        round = Wind.East
        riichi = false
        tsumo = false
        ippatsu = false
        lastTileFromWall = false
        lastDiscard = false
        deadWallDraw = false
        robKan = false
        doubleRiichi = false
    }
    
    func setDealer(dealer:Bool) {
        self.dealer = dealer
        setSeat(Wind.East)
    }
    
    func isDealer() -> Bool {
        return dealer
    }
    
    func setSeat(wind:Wind) {
        seat = wind
    }
    
    func getSeat() -> Wind {
        return seat
    }
    
    func setRound(wind:Wind) {
        round = wind
    }
    
    func getRound() -> Wind {
        return round
    }

    func setRiichi(riichi:Bool, hand:Hand) {
        if riichi {
            if (hand.isClosed() || hand.han.sevenPairs(hand)) {
                self.riichi = riichi
            }
            if (self.riichi && doubleRiichi) {
                doubleRiichi = false
            }
        
        } else {
            self.riichi = riichi
        }
    }
    
    func isRiichi() -> Bool {
        return riichi
    }
    
    func setTsumo(tsumo:Bool) {
        self.tsumo = tsumo
    }
    
    func isTsumo() -> Bool {
        return tsumo
    }
    
    func setIppatsu(ippatsu:Bool) {
        self.ippatsu = ippatsu
    }
    
    func isIppatsu() -> Bool {
        return ippatsu
    }
    
    func setLastTileFromWall(bool:Bool) {
        lastTileFromWall = bool
    }
    
    func isLastTileFromWall() -> Bool {
        return lastTileFromWall
    }
    
    func setLastDiscard(bool:Bool) {
        lastDiscard = bool
    }
    
    func isLastDiscard() -> Bool {
        return lastDiscard
    }
    
    func setDeadWallDraw(bool:Bool) {
        deadWallDraw = bool
    }
    
    func isDeadWallDraw() -> Bool {
        return deadWallDraw
    }
    
    func setRobKan(kan:Bool) {
        robKan = kan
    }
    
    func isRobKan() -> Bool {
        return robKan
    }
    
    func setDoubleRiichi(riichi:Bool, hand:Hand) {
        if riichi {
            if (hand.isClosed() || hand.han.sevenPairs(hand)) {
                doubleRiichi = riichi
            }
            if (self.riichi && doubleRiichi) {
                self.riichi = false
            }
        } else {
            self.doubleRiichi = riichi
        }
    }
    
    func isDoubleRiichi() -> Bool {
        return doubleRiichi
    }
    
    func addDoraTile(tile:Tile) {
        if (currentTileCount(tile) < 4) {
            if doraTiles.count < 10 {
                doraTiles.append(tile)
            }
        sortTiles()
        }
    }
    
    func removeDoraTile() {
        if doraTiles.count > 0 {
            doraTiles.removeLast()
        }
        sortTiles()
    }
    
    func removeAllDoraTiles() {
        doraTiles.removeAll(keepCapacity: true)
    }
    
    func getDoraTiles() -> [Tile] {
        return doraTiles
    }
    
    func currentTileCount(tile:Tile) -> Int {
        var count:Int = 0
        for var i:Int = 0; i < doraTiles.count; i++ {
            if (doraTiles[i].isEqual(tile)) {
                count++
            }
        }
        return count
    }
    
    func sortTiles() {
        for var i:Int = 1; i < doraTiles.count; i++ {
            var value:Tile = doraTiles[i]
            var newIndex:Int = bSearch(value.getRawValue(), left: 0, right: i)
            for var j:Int = i; j > newIndex; j-- {
                doraTiles[j] = doraTiles [j-1]
            }
            doraTiles[newIndex] = value
        }
    }
    
    func bSearch(value:Int, left:Int, right:Int) -> Int {
        if (right < left) { return left }
        let mid:Int = (left + right) / 2
        if (value <= doraTiles[mid].getRawValue()) {
            return bSearch(value, left: left, right: mid-1)
        } else {
            return bSearch(value, left: mid+1, right: right)
        }
    }
}