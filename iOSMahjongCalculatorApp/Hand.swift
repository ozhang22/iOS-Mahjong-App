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
    private var insertedTiles:[Tile]
    var melds:[Meld]
    var pair:Pair!
    var han:Double
    var fu:Double
    var conditions:Conditions
    var basicPoints:Double
    var dictionary:[String:Double]
    
    init() {
        tiles = []
        insertedTiles = []
        han = 0
        fu = 0
        conditions = Conditions()
        basicPoints = 0
        melds = []
        dictionary = [:]
    }
    
    func addTile(tile:Tile) {
        if (currentTileCount(tile) < 4) {
            if tiles.count < 14 {
                tiles.append(tile)
                insertedTiles.append(tile)
                sortTiles()
            }
            if tiles.count == 14 && pair == nil {
                validateHand()
            }
        }
    }
    
    func removeTile() {
        if tiles.count > 0 {
            let toRemove:Tile = insertedTiles.removeLast()
            for (var ii:Int = 0; ii < tiles.count; ii++) {
                if tiles[ii].isEqual(toRemove) {
                    tiles.removeAtIndex(ii)
                    return
                }
            }
        }
        sortTiles()
        invalidateHand()
    }
    
    func removeAllTiles() {
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
            
            melds = tempMelds
            pair = tempPair
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
            
            melds = tempMelds
            pair = tempPair
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
            
            melds = tempMelds
            pair = tempPair
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
            
            melds = tempMelds
            pair = tempPair
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
            
            melds = tempMelds
            pair = tempPair
            return
        }
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
            let pair = Pair(tile1: tiles[2*i], tile2: tiles[2*i + 1])
            if !(pair.isValidPair()) {
                return false
            }
        }
        
        return true
    }
    
    func calculateScore() -> (winner:Double, other1:Double, other2:Double, other3:Double) {
        dictionary = [:]
        let fuHelper = Fu(wh: self)
        let hanHelper = Han(wh: self)
        fu = fuHelper.calculateFu()
        han = hanHelper.calculateHan()
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
        println("han: \(han)")
        println("fu: \(fu)")
        
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
            var value:Tile = tiles[i]
            var newIndex:Int = binarySearch(value.getRawValue(), left: 0, right: i)
            for var j:Int = i; j > newIndex; j-- {
                tiles[j] = tiles [j-1]
            }
            tiles[newIndex] = value
        }
    }
    
    func binarySearch(value:Int, left:Int, right:Int) -> Int {
        if (right < left) {
            return left
        }
        
        let mid:Int = (left + right) / 2
        
        if (value <= tiles[mid].getRawValue()) {
            return binarySearch(value, left: left, right: mid-1)
        } else {
            return binarySearch(value, left: mid+1, right: right)
        }
    }
    
    func clearConditions() {
        if !sevenPairs() {
            for i in 0...3 {
                melds[i].setClosed(false)
            }
        }
        conditions.clearConditions()
    }
}