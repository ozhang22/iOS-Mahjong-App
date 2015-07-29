//
//  DoraTilesViewController.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 12/31/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import UIKit

class DoraTilesViewController: UIViewController {
    
    @IBOutlet weak var DeleteButton: UIButton!
    @IBOutlet weak var ClearButton: UIButton!
    @IBOutlet weak var NextButton: UIBarButtonItem!
    @IBOutlet weak var BackButton: UIBarButtonItem!
    @IBOutlet weak var HandImages: UIImageView!
    
    var winningHand:Hand!
    var values = lookUp
    var images = imageDictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateHandImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Moving forward to the view controller that sets the conditions of the
        // winnning hand, only if there is at least one dora tile
        
        if segue.identifier == "NextConditions" {
            if winningHand.conditions.doraTiles.count < 1 {
                let alertController = UIAlertController(title: "No Dora Tiles", message:
                    "There must be at least one dora tile!", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                presentViewController(alertController, animated: true, completion: nil)
            } else {
                let conditionsController = segue.destinationViewController as! ConditionsViewController
                conditionsController.winningHand = winningHand
            }
        }
            
        // Moving back to the view controller that selects the tiles of the 
        // winning hand, saving the dora tiles
            
        else if segue.identifier == "BackTiles" {
            let tilesController = segue.destinationViewController as! TilesViewController
            tilesController.winningHand = winningHand
        }
    }
    
    // When image tapped, add dora tile to winning hand and display image
    // on bottom of screen
    @IBAction func tileTapped(sender:UITapGestureRecognizer) {
        if let message:String = sender.view?.accessibilityLabel {
            if let tile:Tile = values[message] {
                winningHand.conditions.addDoraTile(tile)
                updateHandImage()
            }
        }
    }
    
    // When delete button is tapped, delete the last dora tile from hand
    @IBAction func deleteTapped(button:UIButton) {
        winningHand.conditions.removeDoraTile()
        clearAllSubViews()
        updateHandImage()
    }
    
    // When clear button is tapped, remove all dora tiles from hand
    @IBAction func clearTapped(button:UIButton) {
        winningHand.conditions.removeAllDoraTiles()
        clearAllSubViews()
    }
    
    // Dismisses view controller to return to this controller
    @IBAction func cancelToDoraTilesViewController(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Adds images of all dora tiles at the bottom of the screen
    func updateHandImage() {
        if winningHand.conditions.doraTiles.count > 0 {
            clearAllSubViews()
            for var i:Int = 0; i < winningHand.conditions.doraTiles.count; i++ {
                updateHandImageAtIndex(i)
            }
        }
    }
    
    // Adds an image of a tile at a specific location, based on the number
    // of dora tiles in the hand
    func updateHandImageAtIndex(index:Int) {
        let xOffset = 40
        let yOffset = 60
        
        let tile = winningHand.conditions.doraTiles[index]
        let key = "\(tile.getRawValue())"
        if let image = imageDictionary[key] {
            let newImage = rescaleImage(image!)
            let imageView = UIImageView(image: newImage)
            imageView.center = CGPoint(x:(25 + xOffset*(index%7)), y:(30 + yOffset*(index/7)))
            HandImages.addSubview(imageView)
        }
    }
    
    // Clear all images of the dora tiles added from the view
    func clearAllSubViews() {
        for view in HandImages.subviews {
            view.removeFromSuperview()
        }
    }
    
    // Helper function to rescale image to correct size.
    // Adapted from: https://gist.github.com/hcatlin/180e81cd961573e3c54d
    func rescaleImage(image: UIImage) -> UIImage {
        var newSize:CGSize = CGSize(width: 35,height: 45)
        let rect = CGRectMake(0,0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        
        image.drawInRect(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
