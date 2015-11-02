//
//  ConditionsViewController.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 12/31/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import UIKit

class ConditionsViewController: UITableViewController {
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var calculateButton: UIBarButtonItem!
    @IBOutlet weak var RiichiSwitch: UISwitch!
    @IBOutlet weak var DoubleRiichiSwitch: UISwitch!
    @IBOutlet weak var Meld1Switch: UISwitch!
    @IBOutlet weak var Meld2Switch: UISwitch!
    @IBOutlet weak var Meld3Switch: UISwitch!
    @IBOutlet weak var Meld4Switch: UISwitch!
    
    var winningHand:Hand!
    
    // Load default conditions of hand, load pre-conditions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winningHand.clearConditions()
        roundLabel.text = "East"
        seatLabel.text = "East"
        RiichiSwitch.enabled = false
        DoubleRiichiSwitch.enabled = false
        
        if winningHand.sevenPairs() {
            Meld1Switch.enabled = false
            Meld1Switch.setOn(false, animated: false)
            Meld2Switch.enabled = false
            Meld2Switch.setOn(false, animated: false)
            Meld3Switch.enabled = false
            Meld3Switch.setOn(false, animated: false)
            Meld4Switch.enabled = false
            Meld4Switch.setOn(false, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Move back to dora tiles controller to reselect dora tiles
        if segue.identifier == "BackDora" {
            let doraController = segue.destinationViewController as! DoraTilesViewController
            doraController.winningHand = winningHand
        }
        
        // Reset to tile select view controller, resetting hand in the process
        else if segue.identifier == "Reset" {
            let tilesController = segue.destinationViewController as! TilesViewController
            tilesController.winningHand.removeAllTiles()
            tilesController.winningHand.conditions.removeAllDoraTiles()
            tilesController.updateHandImage()
        }
    }
    
    // Alters conditions of hand depending on switch that is activated
    @IBAction func tapSwitch(sender:UISwitch) {
        
        func enableRiichi() {
            if !winningHand.isClosed() {
                winningHand.conditions.setRiichi(false, hand: winningHand)
                RiichiSwitch.setOn(false, animated: true)
                RiichiSwitch.enabled = false
            } else {
                RiichiSwitch.enabled = true
            }
        }
        
        func enableDoubleRiichi() {
            if !winningHand.isClosed() {
                winningHand.conditions.setDoubleRiichi(false, hand: winningHand)
                DoubleRiichiSwitch.setOn(false, animated: true)
                DoubleRiichiSwitch.enabled = false
            } else {
                DoubleRiichiSwitch.enabled = true
            }
        }
        
        if let switchName:String = sender.accessibilityLabel {
            
            switch switchName {
            case "Meld1":
                winningHand.melds[0].setClosed(sender.on)
                enableRiichi()
                enableDoubleRiichi()
                break
            case "Meld2":
                winningHand.melds[1].setClosed(sender.on)
                enableRiichi()
                enableDoubleRiichi()
                break
            case "Meld3":
                winningHand.melds[2].setClosed(sender.on)
                enableRiichi()
                enableDoubleRiichi()
                break
            case "Meld4":
                winningHand.melds[3].setClosed(sender.on)
                enableRiichi()
                enableDoubleRiichi()
                break
            case "Riichi":
                winningHand.conditions.setRiichi(sender.on, hand: winningHand)
                DoubleRiichiSwitch.setOn(false, animated:true)
                break
            case "Ippatsu":
                winningHand.conditions.setIppatsu(sender.on)
                break
            case "LastTileFromWall":
                winningHand.conditions.setLastTileFromWall(sender.on)
                break
            case "LastDiscard":
                winningHand.conditions.setLastDiscard(sender.on)
                break
            case "DeadWall":
                winningHand.conditions.setDeadWallDraw(sender.on)
                break
            case "KanRobbed":
                winningHand.conditions.setRobKan(sender.on)
                break
            case "DoubleRiichi":
                winningHand.conditions.setDoubleRiichi(sender.on, hand: winningHand)
                RiichiSwitch.setOn(false, animated:true)
                break
            case "Tsumo":
                winningHand.conditions.setTsumo(sender.on)
            default:
                break
            }
        }
    }
    
    // Pulls up Table View Controller to select round
    @IBAction func selectedRound(segue:UIStoryboardSegue) {
        let roundPickerViewController = segue.sourceViewController as! RoundTableViewController
        if let selectedRound = roundPickerViewController.selectedRound {
            
            switch selectedRound {
            case "East":
                roundLabel.text = "East"
                winningHand.conditions.setRound(Wind.East)
                break
            case "South":
                roundLabel.text = "South"
                winningHand.conditions.setRound(Wind.South)
                break
            case "West":
                roundLabel.text = "West"
                winningHand.conditions.setRound(Wind.West)
                break
            case "North":
                roundLabel.text = "North"
                winningHand.conditions.setRound(Wind.North)
                break
            default:
                roundLabel.text = "Null"
                break
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // Pulls up Table View Controller to select seat
    @IBAction func selectedSeat(segue:UIStoryboardSegue) {
        let seatPickerViewController = segue.sourceViewController as! SeatTableViewController
        if let selectedSeat = seatPickerViewController.selectedSeat {
            
            switch selectedSeat {
            case "East":
                seatLabel.text = "East"
                winningHand.conditions.setSeat(Wind.East)
                break
            case "South":
                seatLabel.text = "South"
                winningHand.conditions.setSeat(Wind.South)
                break
            case "West":
                seatLabel.text = "West"
                winningHand.conditions.setSeat(Wind.West)
                break
            case "North":
                seatLabel.text = "North"
                winningHand.conditions.setSeat(Wind.North)
                break
            default:
                seatLabel.text = "Null"
                break
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // Calculates points of the winning hand when calculate button is pressed
    @IBAction func calculate() {
        let score = winningHand.calculateScore()
        var alertController:UIAlertController
        
        if winningHand.han == 0 {
            alertController = UIAlertController(title: "Chombo!",
                message: "Invalid hand: Player must pay chombo penalty.",
                preferredStyle: .Alert)
        } else {
            alertController = UIAlertController(
                title: "Han: \(winningHand.han), Fu: \(winningHand.fu)",
                message: "\(winningHand.displayDictionary()) \n" +
                    "Winner: \(score.winner) \nPlayer 2: \(score.other1) \n" +
                    "Player 3: \(score.other2) \nPlayer 4: \(score.other3) \n",
                preferredStyle: .Alert)
        }
            
        let cancelAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(cancelAction)
        
        func resetToStart(action:UIAlertAction!) {
            performSegueWithIdentifier("Reset", sender: action)
        }
        
        let resetAction = UIAlertAction (title: "Reset", style: .Cancel, handler: resetToStart)
        alertController.addAction(resetAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}
