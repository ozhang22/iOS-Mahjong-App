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
let lookUp:Dictionary<String, (value: Value, suit: Suit)> =
[
    "Wan1": (value: Value.One, suit: Suit.Wan),
    "Wan2": (value: Value.Two, suit: Suit.Wan),
    "Wan3": (value: Value.Three, suit: Suit.Wan),
    "Wan4": (value: Value.Four, suit: Suit.Wan),
    "Wan5": (value: Value.Five, suit: Suit.Wan),
    "Wan6": (value: Value.Six, suit: Suit.Wan),
    "Wan7": (value: Value.Seven, suit: Suit.Wan),
    "Wan8": (value: Value.Eight, suit: Suit.Wan),
    "Wan9": (value: Value.Nine, suit: Suit.Wan),
    "Pin1": (value: Value.One, suit: Suit.Pin),
    "Pin2": (value: Value.Two, suit: Suit.Pin),
    "Pin3": (value: Value.Three, suit: Suit.Pin),
    "Pin4": (value: Value.Four, suit: Suit.Pin),
    "Pin5": (value: Value.Five, suit: Suit.Pin),
    "Pin6": (value: Value.Six, suit: Suit.Pin),
    "Pin7": (value: Value.Seven, suit: Suit.Pin),
    "Pin8": (value: Value.Eight, suit: Suit.Pin),
    "Pin9": (value: Value.Nine, suit: Suit.Pin),
    "Sou1": (value: Value.One, suit: Suit.Sou),
    "Sou2": (value: Value.Two, suit: Suit.Sou),
    "Sou3": (value: Value.Three, suit: Suit.Sou),
    "Sou4": (value: Value.Four, suit: Suit.Sou),
    "Sou5": (value: Value.Five, suit: Suit.Sou),
    "Sou6": (value: Value.Six, suit: Suit.Sou),
    "Sou7": (value: Value.Seven, suit: Suit.Sou),
    "Sou8": (value: Value.Eight, suit: Suit.Sou),
    "Sou9": (value: Value.Nine, suit: Suit.Sou),
    "East": (value: Value.East, suit: Suit.Wind),
    "South": (value: Value.South, suit: Suit.Wind),
    "West": (value: Value.West, suit: Suit.Wind),
    "North": (value: Value.North, suit: Suit.Wind),
    "Red": (value: Value.Red, suit: Suit.Dragon),
    "Green": (value: Value.Green, suit: Suit.Dragon),
    "White": (value: Value.White, suit: Suit.Dragon)
]

// Lookup table to associate a tile (in raw value) with an image
// to display on the screen

let imageDictionary =
[
    "11": UIImage(named: "MJw1.png"),
    "12": UIImage(named: "MJw2.png"),
    "13": UIImage(named: "MJw3.png"),
    "14": UIImage(named: "MJw4.png"),
    "15": UIImage(named: "MJw5.png"),
    "16": UIImage(named: "MJw6.png"),
    "17": UIImage(named: "MJw7.png"),
    "18": UIImage(named: "MJw8.png"),
    "19": UIImage(named: "MJw9.png"),
    "21": UIImage(named: "MJt1.png"),
    "22": UIImage(named: "MJt2.png"),
    "23": UIImage(named: "MJt3.png"),
    "24": UIImage(named: "MJt4.png"),
    "25": UIImage(named: "MJt5.png"),
    "26": UIImage(named: "MJt6.png"),
    "27": UIImage(named: "MJt7.png"),
    "28": UIImage(named: "MJt8.png"),
    "29": UIImage(named: "MJt9.png"),
    "31": UIImage(named: "MJs1bird.png"),
    "32": UIImage(named: "MJs2.png"),
    "33": UIImage(named: "MJs3.png"),
    "34": UIImage(named: "MJs4.png"),
    "35": UIImage(named: "MJs5.png"),
    "36": UIImage(named: "MJs6.png"),
    "37": UIImage(named: "MJs7.png"),
    "38": UIImage(named: "MJs8.png"),
    "39": UIImage(named: "MJs9.png"),
    "64": UIImage(named: "MJd1.png"),
    "65": UIImage(named: "MJd2.png"),
    "66": UIImage(named: "MJd3.png"),
    "50": UIImage(named: "MJf1.png"),
    "51": UIImage(named: "MJf2.png"),
    "52": UIImage(named: "MJf3.png"),
    "53": UIImage(named: "MJf4.png")
]
