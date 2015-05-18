//
//  Pair.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 12/14/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import Foundation

public class Pair {
    
    var tile1:Tile
    var tile2:Tile
    
    init(tile1:Tile, tile2:Tile) {
        self.tile1 = tile1
        self.tile2 = tile2
    }
    
    func isValidPair() -> Bool {
        return tile1.isEqual(tile2)
    }
    
    func isEqual(pair:Pair) -> Bool {
        return ((tile1.isEqual(pair.tile1)) && (tile2.isEqual(pair.tile2)))
    }
}