//
//  Hand.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 12/13/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import Foundation

public class Hand {

    var tiles:[Tile]
    var melds:[Meld]
    var pair:Pair!
    var han:Double
    var fu:Double
    var conditions:Conditions
    var basicPoints:Double
    var dictionary:[String:Double]

    init() {
        tiles = []
        han = 0
        fu = 0
        conditions = Conditions()
        basicPoints = 0
        melds = []
        dictionary = [:]
    }

    func addTile(tile:Tile, status:Status=Status.None) {
        tile.status = status
        if canAddTile(tile) {
            if tiles.count < 14 {
                tiles.append(tile)
                sortTiles()
            }
            if tiles.count == 14 && pair == nil {
                tile.setWait(true)
                validateHand()
            }
        }
    }

    func addMeld(tile:Tile, status:Status) {
        if tiles.count > 11 {
            return
        }

        switch status {
            case .Chi:
            var rawvalue = tile.value.rawValue
            if rawvalue <= 7 {
                let tile2 = Tile(value:Value(rawValue:rawvalue+1)!, suit:tile.suit)
                let tile3 = Tile(value:Value(rawValue:rawvalue+2)!, suit:tile.suit)
                if (canAddTile(tile) && canAddTile(tile2) && canAddTile(tile3)) {
                    addTile(tile,status:status)
                    addTile(tile2,status:status)
                    addTile(tile3,status:status)
                }
            }
            case .Pon:
            if currentTileCount(tile) < 2 {
                addTile(tile,status:status)
                addTile(tile,status:status)
                addTile(tile,status:status)
            }
            case .Kan, .ClosedKan:
            if currentTileCount(tile) == 0 {
                addTile(tile,status:status)
                addTile(tile,status:status)
                addTile(tile,status:status)
            }
            default:
            return
        }
    }

    func addDoraTile(tile:Tile) {
        conditions.addDoraTile(tile, hand: self)
    }

    func removeTileAtIndex(index:Int) {
        if tiles.count > 0 {
            clearWaits()
            tiles.removeAtIndex(index)
        }
        sortTiles()
        invalidateHand()
    }

    func removeAllOfTile(tile:Tile) {
        for var i=0; i<tiles.count; i++ {
            if (tile.isEqual(tiles[i]) && tile.status == tiles[i].status) {
                tiles.removeAtIndex(i)
                i--
            }
        }
    }

    func removeAllTiles() {
        for tile in tiles {
            tile.setWait(false)
        }
        tiles.removeAll(keepCapacity: true)
        invalidateHand()
    }

    func containsTile(tile:Tile) -> Bool {
        for t in tiles {
            if tile.isEqual(t) {
                return true
            }
        }
        return false
    }

    func currentTileCount(tile:Tile) -> Int {
        var count:Int = 0
        for var i:Int = 0; i < tiles.count; i++ {
            if (tiles[i].isEqual(tile)) {
                count++
            }
        }
        return count
    }

    func canAddTile(tile:Tile) -> Bool {
        for var i:Int = 0; i < tiles.count; i++ {
            if tiles[i].isEqual(tile) {
                if (tiles[i].status == .Kan || tiles[i].status == .ClosedKan) {
                    return currentTileCount(tile) < 3
                }
            }
        }

        return currentTileCount(tile) < 4
    }

    func validateHand() {
        var tempTiles:[Tile] = []
        var tempMelds:[Meld] = []

        // 012 345 678 91011
        check: for ii in 0...12 {

            let tempPair = Pair(tile1: tiles[ii], tile2: tiles[ii+1])
            if !tempPair.isValidPair() {
                continue check
            }

            for var jj:Int = 0; jj < tiles.count; jj++ {
                if jj != ii && jj != ii+1 {
                    tempTiles.append(tiles[jj])
                }
            }

            for kk in 0...3 {
                tempMelds.append(Meld(tile1: tempTiles[3*kk],
                    tile2: tempTiles[3*kk + 1], tile3: tempTiles[3*kk + 2]))

                if !tempMelds[kk].isValid() {
                    tempTiles.removeAll(keepCapacity: true)
                    tempMelds.removeAll(keepCapacity: true)
                    continue check
                }
            }

            setMeldsAndPairs(tempMelds, tempPair: tempPair)
            return
        }

        // 024 135 678 91011
        check: for ii in 0...12 {

            let tempPair = Pair(tile1: tiles[ii], tile2: tiles[ii+1])
            if !tempPair.isValidPair() {
                continue check
            }

            for var jj:Int = 0; jj < tiles.count; jj++ {
                if jj != ii && jj != ii+1 {
                    tempTiles.append(tiles[jj])
                }
            }

            tempMelds.append(Meld(tile1: tempTiles[0], tile2: tempTiles[2],
                tile3: tempTiles[4]))
            tempMelds.append(Meld(tile1: tempTiles[1], tile2: tempTiles[3],
                tile3: tempTiles[5]))
            tempMelds.append(Meld(tile1: tempTiles[6], tile2: tempTiles[7],
                tile3: tempTiles[8]))
            tempMelds.append(Meld(tile1: tempTiles[9], tile2: tempTiles[10],
                tile3: tempTiles[11]))

            for kk in 0...3 {
                if !tempMelds[kk].isValid() {
                    tempTiles.removeAll(keepCapacity: true)
                    tempMelds.removeAll(keepCapacity: true)
                    continue check
                }
            }

            setMeldsAndPairs(tempMelds, tempPair: tempPair)
            return
        }

        // 012 345 6810 7911
        check: for ii in 0...12 {

            let tempPair = Pair(tile1: tiles[ii], tile2: tiles[ii+1])
            if !tempPair.isValidPair() {
                continue check
            }

            for var jj:Int = 0; jj < tiles.count; jj++ {
                if jj != ii && jj != ii+1 {
                    tempTiles.append(tiles[jj])
                }
            }

            tempMelds.append(Meld(tile1: tempTiles[0], tile2: tempTiles[1],
                tile3: tempTiles[2]))
            tempMelds.append(Meld(tile1: tempTiles[3], tile2: tempTiles[4],
                tile3: tempTiles[5]))
            tempMelds.append(Meld(tile1: tempTiles[6], tile2: tempTiles[8],
                tile3: tempTiles[10]))
            tempMelds.append(Meld(tile1: tempTiles[7], tile2: tempTiles[9],
                tile3: tempTiles[11]))

            for kk in 0...3 {
                if !tempMelds[kk].isValid() {
                    tempTiles.removeAll(keepCapacity: true)
                    tempMelds.removeAll(keepCapacity: true)
                    continue check
                }
            }

            setMeldsAndPairs(tempMelds, tempPair: tempPair)
            return
        }

        // 024 135 678 91011
        check: for ii in 0...12 {

            let tempPair = Pair(tile1: tiles[ii], tile2: tiles[ii+1])
            if !tempPair.isValidPair() {
                continue check
            }

            for var jj:Int = 0; jj < tiles.count; jj++ {
                if jj != ii && jj != ii+1 {
                    tempTiles.append(tiles[jj])
                }
            }

            tempMelds.append(Meld(tile1: tempTiles[0], tile2: tempTiles[2],
                tile3: tempTiles[4]))
            tempMelds.append(Meld(tile1: tempTiles[1], tile2: tempTiles[3],
                tile3: tempTiles[5]))
            tempMelds.append(Meld(tile1: tempTiles[6], tile2: tempTiles[8],
                tile3: tempTiles[10]))
            tempMelds.append(Meld(tile1: tempTiles[7], tile2: tempTiles[9],
                tile3: tempTiles[11]))

            for kk in 0...3 {
                if !tempMelds[kk].isValid() {
                    tempTiles.removeAll(keepCapacity: true)
                    tempMelds.removeAll(keepCapacity: true)
                    continue check
                }
            }

            setMeldsAndPairs(tempMelds, tempPair: tempPair)
            return
        }

        // 012 357 468 91011
        check: for ii in 0...12 {

            let tempPair = Pair(tile1: tiles[ii], tile2: tiles[ii+1])
            if !tempPair.isValidPair() {
                continue check
            }

            for var jj:Int = 0; jj < tiles.count; jj++ {
                if jj != ii && jj != ii+1 {
                    tempTiles.append(tiles[jj])
                }
            }

            tempMelds.append(Meld(tile1: tempTiles[0], tile2: tempTiles[1],
                tile3: tempTiles[2]))
            tempMelds.append(Meld(tile1: tempTiles[3], tile2: tempTiles[5],
                tile3: tempTiles[7]))
            tempMelds.append(Meld(tile1: tempTiles[4], tile2: tempTiles[6],
                tile3: tempTiles[8]))
            tempMelds.append(Meld(tile1: tempTiles[9], tile2: tempTiles[10],
                tile3: tempTiles[11]))

            for kk in 0...3 {
                if !tempMelds[kk].isValid() {
                    tempTiles.removeAll(keepCapacity: true)
                    tempMelds.removeAll(keepCapacity: true)
                    continue check
                }
            }

            setMeldsAndPairs(tempMelds, tempPair: tempPair)
            return
        }
    }

    func setMeldsAndPairs(tempMelds:[Meld], tempPair:Pair) {
        for meld in tempMelds {
            if meld.tile1.status == Status.None || meld.tile1.status == Status.ClosedKan {
                meld.setClosed()
            }

            if meld.tile1.status == Status.Kan || meld.tile1.status == Status.ClosedKan {
                meld.setKan()
            }
        }

        melds = tempMelds
        pair = tempPair
    }

    func invalidateHand() {
        melds = [];
        pair = nil;
    }

    func isClosed() -> Bool {
        for m in melds {
            if !(m.isClosed()) {
                return false
            }
        }
        return true
    }

    func isValid() -> Bool {
        if tiles.count < 14 {
            return false
        }

        if sevenPairs() {
            return true
        }

        for meld in melds {
            if !meld.isValid() {
                return false
            }
        }

        return pair != nil && pair.isValidPair()
    }

    func sevenPairs() -> Bool {
        if tiles.count < 14 {
            return false
        }

        for i in 0...(tiles.count/2 - 1) {
            if !tiles[2*i].isEqual(tiles[2*i+1]) {
                return false
            }
        }

        return true
    }

    func calculateScore() -> (winner:Double, other1:Double, other2:Double, other3:Double) {
        dictionary = [:]
        fu = Fu(wh: self).calculateFu()
        han = Han(wh: self).calculateHan()
        calculateBasicPoints()

        if conditions.isDealer() {
            if conditions.isTsumo() {
                return (roundPoints(basicPoints*6), roundPoints(basicPoints*(-2)),
                    roundPoints(basicPoints*(-2)), roundPoints(basicPoints*(-2)))
            } else  {
                return (roundPoints(basicPoints*6), roundPoints(basicPoints*(-6)), 0, 0)
            }
        } else {
            if conditions.isTsumo() {
                return (roundPoints(basicPoints*4), roundPoints(basicPoints*(-2)),
                    roundPoints(basicPoints*(-1)), roundPoints(basicPoints*(-1)))
            } else  {
                return (roundPoints(basicPoints*4), roundPoints(basicPoints*(-4)), 0, 0)
            }
        }
    }

    func calculateBasicPoints() {
        var points:Double

        switch han {
        case 0:
            points = 0
        case 1, 2:
            points = fu*pow(2, 2+han)
        case 3:
            if fu >= 70 {
                points = 2000
            } else {
                points = fu*pow(2, 2+han)
            }
        case 4:
            if fu >= 40 {
                points = 2000
            } else {
                points = fu*pow(2, 2+han)
            }
        case 5:
            points = 2000
        case 6, 7:
            points = 3000
        case 8, 9, 10:
            points = 4000
        case 11, 12:
            points = 6000
        default:
            points = 8000
        }

        basicPoints = points
    }

    func roundPoints(count:Double) -> Double {
        if count >= 0 {
            if round(count/100)*100 < count/100*100 {
                return round((count+100)/100)*100
            }
            return round(count/100)*100
        }
        else {
            if round(count/100)*100 > count/100*100 {
                return round((count-100)/100)*100
            }
            return round(count/100)*100
        }
    }

    func displayDictionary() -> String {
        var message:String = ""
        for (key, value) in dictionary {
            message += "\(key): \(value)\n"
        }
        return message
    }

    func sortTiles() {
        for var i:Int = 1; i < tiles.count; i++ {
            var tileToSort:Tile = tiles[i]
            var newIndex:Int = binarySearch(tileToSort, left: 0, right: i)
            for var j:Int = i; j > newIndex; j-- {
                tiles[j] = tiles[j-1]
            }
            tiles[newIndex] = tileToSort
        }
    }

    func binarySearch(tile:Tile, left:Int, right:Int) -> Int {
        if (right < left) {
            return left
        }

        let mid:Int = (left + right) / 2

        if tile.isGreaterThan(tiles[mid]) {
            return binarySearch(tile, left: mid+1, right: right)
        } else {
            return binarySearch(tile, left: left, right: mid-1)
        }
    }

    func clearWaits() {
        for tile in tiles {
            tile.setWait(false)
        }
    }
}