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
                return (basicPoints*6, basicPoints*(-2), basicPoints*(-2), basicPoints*(-2))
            } else  {
                return (basicPoints*6, basicPoints*(-6), 0, 0)
            }
        } else {
            if winningHand.conditions.isTsumo() {
                return (basicPoints*4, basicPoints*(-2), basicPoints*(-1), basicPoints*(-1))
            } else  {
                return (basicPoints*4, basicPoints*(-4), 0, 0)
            }
        }
    }
}