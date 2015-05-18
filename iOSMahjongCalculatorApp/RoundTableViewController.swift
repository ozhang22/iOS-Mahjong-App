//
//  RoundTableViewController.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 1/5/15.
//  Copyright (c) 2015 Oliver Zhang. All rights reserved.
//

import UIKit

class RoundTableViewController: UITableViewController {

    var rounds:[String]!
    var selectedRound:String? = nil
    var selectedRoundIndex:Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rounds = ["East",
            "South",
            "West",
            "North"]
        if let round = selectedRound {
            selectedRoundIndex = find(rounds, round)!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rounds.count
    }
    
    // Loads table into view
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RoundCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = rounds[indexPath.row]
        
        if indexPath.row == selectedRoundIndex {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    // Changes round to that selected on screen
    // Adapted from: http://www.raywenderlich.com/81880/storyboards-tutorial-swift-part-2
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //Other row is selected - need to deselect it
        if let index = selectedRoundIndex {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        selectedRoundIndex = indexPath.row
        selectedRound = rounds[indexPath.row]
        
        //Update the checkmark for the current row
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
    }
    
    // Saves the round selected and returns to the conditions controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveSelectedRound" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            selectedRoundIndex = indexPath?.row
            if let index = selectedRoundIndex {
                selectedRound = rounds[index]
            }
        }
    }
}
