//
//  TilesViewController.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 12/31/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import UIKit

class TilesViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var DeleteButton: UIButton!
    @IBOutlet weak var ClearButton: UIButton!
    @IBOutlet weak var NextButton: UIBarButtonItem!
    @IBOutlet weak var HandImages: UIImageView!
    
    var winningHand:Hand!
    var values = lookUp
    var images = imageDictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winningHand = Hand()
        HandImages.userInteractionEnabled = true
        updateHandImage()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Move on to dora tiles only when 14 tiles are selected and that the tiles
        // selected form a valid hand
        if segue.identifier == "NextDora" {
            if winningHand.isValid() {
                let doraController = segue.destinationViewController as! DoraTilesViewController
                doraController.winningHand = winningHand
                //doraController.updateHandImage()
            } else {
                let alertController = UIAlertController(title: "Invalid hand", message:
                    "Please input a valid hand.", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func gestureRecognizer(UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
            return true
    }
    
    // When image tapped, add tile to winning hand and display image
    // on bottom of screen
    @IBAction func tileTapped(sender:UITapGestureRecognizer) {
        if let message:String = sender.view?.accessibilityLabel {
            if let tile:Tile = values[message] {
                winningHand.addTile(tile)
                updateHandImage()
            }
        }
    }
    
    // When delete button is tapped, delete the last dora tile from hand
    @IBAction func deleteTapped(button:UIButton) {
        winningHand.removeTile()
        updateHandImage()
    }
    
    // When clear button is tapped, remove all dora tiles from hand
    @IBAction func clearTapped(button:UIButton) {
        winningHand.removeAllTiles()
        clearAllSubViews()
    }
    
    // Dismisses view controller to return to this controller
    @IBAction func cancelToTilesViewController(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Adds images of all tiles at the bottom of the screen
    func updateHandImage() {
        clearAllSubViews()
        for var i:Int = 0; i < winningHand.tiles.count; i++ {
            updateHandImageAtIndex(i)
        }
    }
    
    // Adds an image of a tile at a specific location, based on the number
    // of tiles in the hand
    func updateHandImageAtIndex(index:Int) {
        let xOffset = 40
        let yOffset = 60
        let redXOffset:Double = 0.4
        let redYOffset:Double = 2
        
        let tile = winningHand.tiles[index]
        let key = "\(tile.getRawValue())"
        if let image = imageDictionary[key] {
            let newImage = rescaleImage(image!, width: 35, height: 45)
            let imageView = UIImageView(image: newImage)
            imageView.center = CGPoint(x: (25 + xOffset*(index%7)), y: (30 + yOffset*(index/7)))
            imageView.userInteractionEnabled = true
            
            let recognizer = UITapGestureRecognizer(target: self, action:Selector("handTileTapped:"))
            recognizer.delegate = self
            imageView.addGestureRecognizer(recognizer)
            imageView.accessibilityLabel = "\(index)"
            
            HandImages.addSubview(imageView)
            
            if tile.wait {
                let redDot = UIImage(named: "RedDot.png")
                let redView = UIImageView(image: redDot)
                redView.frame = CGRect(x:Double(9.5 + redXOffset*Double(index%7)), y:Double(redYOffset*Double(index/7) - 15),
                    width: 12, height: 12)
                
                imageView.addSubview(redView)
            }
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
    func rescaleImage(image: UIImage, width: Int, height: Int) -> UIImage {
        var newSize:CGSize = CGSize(width: width, height: height)
        let rect = CGRectMake(0,0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        
        image.drawInRect(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    // Changes the wait of the tile, which affects the points of the hand
    func handTileTapped(sender: UITapGestureRecognizer) {
        if let message:String = sender.view?.accessibilityLabel {
            if let index:Int = message.toInt() {
                winningHand.tiles[index].changeWait()
                updateHandImage()
            }
        }
    }
}
