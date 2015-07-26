//
//  Fu.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 12/16/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import Foundation

public class Fu {
    
    var count:Double
    var wh:Hand

    init(wh:Hand) {
        self.count = 0
        self.wh = wh
    }
    
    func calculateFu() -> Double {
        self.count = 0
        
        func calculateClosedHand() {
            if !(wh.conditions.isTsumo()) {
                for meld in wh.melds {
                    if !(meld.isClosed()) { return }
                }
                count = count + 10
                println("closed hand fu +10")
            }
        }
        
        func calculateFuMelds() {
            for meld in wh.melds {
                if (meld.isTriplet()) {
                    var acc:Double = 2
                    
                    if (meld.isClosed()) { acc = acc*2 }
                    if (meld.isKan()) { acc = acc*4 }
                    if (meld.tile1.isTerminalOrHonor()) { acc = acc*2 }
                    count = count + acc
                    println("triplet fu + \(acc)")
                }
            }
            if (wh.pair.tile1.isDragon()) ||
                (wh.pair.tile1.isCorrectWind(wh.conditions.seat, wind2: wh.conditions.round)) {
                    count = count + 2
                    println("wind/dragon fu +2")
            }
        }
        
        func calculateFuWaits() {
            if (wh.pair.tile1.wait || wh.pair.tile2.wait) {
                println("wait fu +2")
                count = count + 2
            }
            else {
                for meld in wh.melds {
                    if (meld.isSequence()) && (((meld.tile2.wait) ||
                        (meld.tile1.value == Value.One) || (meld.tile3.value == Value.Nine))) {
                            count = count + 2
                            println("wait fu +2")
                            return
                    }
                }
            }
        }
        
        func calculateFuTsumo() {
            if (wh.conditions.isTsumo()) {
                count = count + 2
                println("tsumo fu +2")
            }
        }
        
        func roundFu() {
            if round(count/10)*10 < count/10*10 {
                count = round((count+10)/10)*10
            }
            count = round(count/10)*10
        }
        
        count = 20
        if wh.sevenPairs() {
            count = 25
            println("sevenPairs fu =25")
            return count
        }
        calculateClosedHand()
        calculateFuMelds()
        calculateFuWaits()
        calculateFuTsumo()
        roundFu()
        return count
    }

}