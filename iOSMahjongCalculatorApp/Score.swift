//
//  Score.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 12/14/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import Foundation

public class Score {
    
    var winningHand:Hand
    var basicPoints:Double
    
    init(winningHand:Hand, basicPoints:Double) {
        self.winningHand = winningHand
        self.basicPoints = basicPoints
    }
    
    func distributePoints() -> (winner:Double, other1:Double, other2:Double, other3:Double) {
        if winningHand.conditions.isDealer() {
            if winningHand.conditions.isTsumo() {
                return (roundPoints(basicPoints*6), roundPoints(basicPoints*(-2)),
                    roundPoints(basicPoints*(-2)), roundPoints(basicPoints*(-2)))
            } else  {
                return (roundPoints(basicPoints*6), roundPoints(basicPoints*(-6)), 0, 0)
            }
        } else {
            if winningHand.conditions.isTsumo() {
                return (roundPoints(basicPoints*4), roundPoints(basicPoints*(-2)),
                    roundPoints(basicPoints*(-1)), roundPoints(basicPoints*(-1)))
            } else  {
                return (roundPoints(basicPoints*4), roundPoints(basicPoints*(-4)), 0, 0)
            }
        }
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
}