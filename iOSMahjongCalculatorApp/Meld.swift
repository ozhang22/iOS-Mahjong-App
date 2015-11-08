//
//  Sequence.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 12/14/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import Foundation

public class Meld {
    
    var tile1:Tile
    var tile2:Tile
    var tile3:Tile
    private var closed:Bool
    private var kan:Bool
    
    init(tile1:Tile, tile2:Tile, tile3:Tile) {
        self.tile1 = tile1
        self.tile2 = tile2
        self.tile3 = tile3
        closed = false
        kan = false
    }
    
    func setClosed(closed:Bool) {
        self.closed = closed
    }
    
    func isClosed() -> Bool {
        return closed
    }
    
    func setKan(kan:Bool) {
        self.kan = kan
    }
    
    func isKan() -> Bool {
        return kan
    }

    func isTriplet() -> Bool {
        return (tile1.isEqual(tile2)) && (tile1.isEqual(tile3))
            && (tile2.isEqual(tile3))
    }
    
    func isSequence() -> Bool {
        return tile1.isSameSuit(tile2) && tile1.isSameSuit(tile3)
        && tile2.isSameSuit(tile3) && tile1.isOneValueGreaterThan(tile2)
        && tile2.isOneValueGreaterThan(tile3)
    }
    
    func isValid() -> Bool {
        return isTriplet() || isSequence()
    }
    
    func isEqual(meld:Meld) -> Bool {
        return (tile1.isEqual(meld.tile1) && tile2.isEqual(meld.tile2) && tile3.isEqual(meld.tile3))
    }
}
