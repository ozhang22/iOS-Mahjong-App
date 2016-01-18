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

    func isDealer() -> Bool {
        return seat == .East
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
            if (hand.isClosed() || hand.sevenPairs()) {
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
            if (hand.isClosed() || hand.sevenPairs()) {
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

    func addDoraTile(tile:Tile, hand:Hand) {
        if canAddTile(tile, hand: hand) {
            doraTiles.append(tile)
            sortTiles()
        }
    }

    func removeDoraTile(index:Int) {
        if doraTiles.count > 0 {
            doraTiles.removeAtIndex(index)
        }
        sortTiles()
    }

    func removeAllDoraTiles() {
        doraTiles.removeAll(keepCapacity: true)
    }

    func getDoraTiles() -> [Tile] {
        return doraTiles
    }

    func currentTileCount(tile:Tile, hand:Hand) -> Int {
        var count:Int = 0
        for var i:Int = 0; i < hand.tiles.count; i++ {
            if (hand.tiles[i].isEqual(tile)) {
                count++
            }
        }
        for var i:Int = 0; i < doraTiles.count; i++ {
            if (doraTiles[i].isEqual(tile)) {
                count++
            }
        }
        return count
    }

    func canAddTile(tile:Tile, hand:Hand) -> Bool {
        if doraTiles.count > 10 {
            return false
        }

        for var i:Int = 0; i < hand.tiles.count; i++ {
            if hand.tiles[i].isEqual(tile) {
                if (hand.tiles[i].status == Status.Kan || hand.tiles[i].status == Status.ClosedKan) {
                    return currentTileCount(tile, hand: hand) < 3
                }
            }
        }

        return currentTileCount(tile, hand: hand) < 4
    }

    func sortTiles() {
        for var i:Int = 1; i < doraTiles.count; i++ {
            var tileToSort:Tile = doraTiles[i]
            var newIndex:Int = binarySearch(tileToSort, left: 0, right: i)
            for var j:Int = i; j > newIndex; j-- {
                doraTiles[j] = doraTiles[j-1]
            }
            doraTiles[newIndex] = tileToSort
        }
    }

    func binarySearch(tile:Tile, left:Int, right:Int) -> Int {
        if (right < left) {
            return left
        }
        
        let mid:Int = (left + right) / 2
        
        if tile.isGreaterThan(doraTiles[mid]) {
            return binarySearch(tile, left: mid+1, right: right)
        } else {
            return binarySearch(tile, left: left, right: mid-1)
        }
    }
}