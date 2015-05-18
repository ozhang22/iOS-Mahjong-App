The following repository is sample code for a iOS Mahjong points calculator application. This application is designed to calculate the points of a mahjong hand after a player has won. Currently a work in progress. For more information on the game, please see http://en.wikipedia.org/wiki/Japanese_Mahjong.

Tile.swift, Meld.swift, and Pair.swift stores characteristics of tiles that help form a player's winning hand. A player wins if they have formed 4 valid melds (of three tiles each) and 1 valid pair (of two tiles).

Hand.swift contains code that stores the tiles of the player's winnning hand. It contains an insertion sort algorithm and binary search to maintain tile order based on suit and value.

TilesViewController.swift contains event-handling code that is a view controller to display the tiles onto a screen. It allows users to tap a tile on a screen and adds it to the user's mahjong hand. The graphical interface updates in response to the insertion or deletion of a tile.
