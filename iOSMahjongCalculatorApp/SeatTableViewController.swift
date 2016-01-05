//
//  SeatTableViewController.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 1/5/15.
//  Copyright (c) 2015 Oliver Zhang. All rights reserved.
//

import UIKit

class SeatTableViewController: UITableViewController {

    var seats:[String]!
    var selectedSeat:String? = nil
    var selectedSeatIndex:Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        seats = ["East",
            "South",
            "West",
            "North"]
        if let seat = selectedSeat {
            selectedSeatIndex = find(seats, seat)!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seats.count
    }

    // Loads table into view
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SeatCell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = seats[indexPath.row]
        
        if indexPath.row == selectedSeatIndex {
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
        if let index = selectedSeatIndex {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }

        selectedSeatIndex = indexPath.row
        selectedSeat = seats[indexPath.row]

        //update the checkmark for the current row
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
    }

    // Saves the round selected and returns to the conditions controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveSelectedSeat" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            selectedSeatIndex = indexPath?.row
            if let index = selectedSeatIndex {
                selectedSeat = seats[index]
            }
        }
    }
}
