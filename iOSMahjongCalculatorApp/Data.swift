//
//  Data.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 12/31/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import Foundation
import UIKit


// Lookup table to associate a description of an image with a tile

let lookUp:[String:Tile] =
[
    "Sou1": Tile(value: Value.One, suit: Suit.Sou),
    "Sou2": Tile(value: Value.Two, suit: Suit.Sou),
    "Sou3": Tile(value: Value.Three, suit: Suit.Sou),
    "Sou4": Tile(value: Value.Four, suit: Suit.Sou),
    "Sou5": Tile(value: Value.Five, suit: Suit.Sou),
    "Sou6": Tile(value: Value.Six, suit: Suit.Sou),
    "Sou7": Tile(value: Value.Seven, suit: Suit.Sou),
    "Sou8": Tile(value: Value.Eight, suit: Suit.Sou),
    "Sou9": Tile(value: Value.Nine, suit: Suit.Sou),
    "Pin1": Tile(value: Value.One, suit: Suit.Pin),
    "Pin2": Tile(value: Value.Two, suit: Suit.Pin),
    "Pin3": Tile(value: Value.Three, suit: Suit.Pin),
    "Pin4": Tile(value: Value.Four, suit: Suit.Pin),
    "Pin5": Tile(value: Value.Five, suit: Suit.Pin),
    "Pin6": Tile(value: Value.Six, suit: Suit.Pin),
    "Pin7": Tile(value: Value.Seven, suit: Suit.Pin),
    "Pin8": Tile(value: Value.Eight, suit: Suit.Pin),
    "Pin9": Tile(value: Value.Nine, suit: Suit.Pin),
    "Wan1": Tile(value: Value.One, suit: Suit.Wan),
    "Wan2": Tile(value: Value.Two, suit: Suit.Wan),
    "Wan3": Tile(value: Value.Three, suit: Suit.Wan),
    "Wan4": Tile(value: Value.Four, suit: Suit.Wan),
    "Wan5": Tile(value: Value.Five, suit: Suit.Wan),
    "Wan6": Tile(value: Value.Six, suit: Suit.Wan),
    "Wan7": Tile(value: Value.Seven, suit: Suit.Wan),
    "Wan8": Tile(value: Value.Eight, suit: Suit.Wan),
    "Wan9": Tile(value: Value.Nine, suit: Suit.Wan),
    "East": Tile(value: Value.East, suit: Suit.Wind),
    "South": Tile(value: Value.South, suit: Suit.Wind),
    "West": Tile(value: Value.West, suit: Suit.Wind),
    "North": Tile(value: Value.North, suit: Suit.Wind),
    "Red": Tile(value: Value.Red, suit: Suit.Dragon),
    "Green": Tile(value: Value.Green, suit: Suit.Dragon),
    "White": Tile(value: Value.White, suit: Suit.Dragon)
]

// Lookup table to associate a tile (in raw value) with an image
// to display on the screen

let imageDictionary =
[
    "1 1": UIImage(named: "MJt1.png"),
    "1 2": UIImage(named: "MJt2.png"),
    "1 3": UIImage(named: "MJt3.png"),
    "1 4": UIImage(named: "MJt4.png"),
    "1 5": UIImage(named: "MJt5.png"),
    "1 6": UIImage(named: "MJt6.png"),
    "1 7": UIImage(named: "MJt7.png"),
    "1 8": UIImage(named: "MJt8.png"),
    "1 9": UIImage(named: "MJt9.png"),
    "2 1": UIImage(named: "MJs1bird.png"),
    "2 2": UIImage(named: "MJs2.png"),
    "2 3": UIImage(named: "MJs3.png"),
    "2 4": UIImage(named: "MJs4.png"),
    "2 5": UIImage(named: "MJs5.png"),
    "2 6": UIImage(named: "MJs6.png"),
    "2 7": UIImage(named: "MJs7.png"),
    "2 8": UIImage(named: "MJs8.png"),
    "2 9": UIImage(named: "MJs9.png"),
    "3 1": UIImage(named: "MJw1.png"),
    "3 2": UIImage(named: "MJw2.png"),
    "3 3": UIImage(named: "MJw3.png"),
    "3 4": UIImage(named: "MJw4.png"),
    "3 5": UIImage(named: "MJw5.png"),
    "3 6": UIImage(named: "MJw6.png"),
    "3 7": UIImage(named: "MJw7.png"),
    "3 8": UIImage(named: "MJw8.png"),
    "3 9": UIImage(named: "MJw9.png"),
    "5 14": UIImage(named: "MJd1.png"),
    "5 15": UIImage(named: "MJd2.png"),
    "5 16": UIImage(named: "MJd3.png"),
    "4 10": UIImage(named: "MJf1.png"),
    "4 11": UIImage(named: "MJf2.png"),
    "4 12": UIImage(named: "MJf3.png"),
    "4 13": UIImage(named: "MJf4.png")
]
