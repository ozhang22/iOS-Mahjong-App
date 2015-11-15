//
//  TilesViewController.swift
//  MyNewProject
//
//  Created by Oliver Zhang on 12/31/14.
//  Copyright (c) 2014 Oliver Zhang. All rights reserved.
//

import UIKit

class TilesViewController: UIViewController, UIGestureRecognizerDelegate {

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

    // When clear button is tapped, remove all dora tiles from hand
    @IBAction func clearTapped(button:UIButton) {
        winningHand.removeAllTiles()
        clearAllSubViews()
    }

    // Dismisses view controller to return to this controller
    @IBAction func cancelToTilesViewController(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // Adds images of all tiles of hand at the bottom of the screen iteratively
    func updateHandImage() {
        // Clear all images of the tiles in hand added from the view
        clearAllSubViews()

        // Some constants about the screen size
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth:Double = Double(screenSize.width)
        let screenHeight:Double = Double(screenSize.height)

        // Using screen dimensions to determine x,y offset of first tile from UI view
        let xOffset:Double = screenWidth/7.11
        let yOffset:Double = screenHeight/9
        let xRedOffset:Double = screenWidth/1600
        let yRedOffset:Double = screenHeight/400

        // Some constants about the size of the image to be created
        let imageWidth:Double = screenWidth/9.14
        let imageHeight:Double = screenHeight/12.62

        // Adds an image of each tile at a specific location, based on the number
        // of tiles in the hand
        for var index:Int = 0; index < winningHand.tiles.count; index++ {
            // Get where the tile is supposed to be relative to other tiles
            let xRelIndex:Double = Double(index%7)
            let yRelIndex:Double = Double(index/7)

            // Define the centre of the image to be created
            let xImageCenter:Double = screenWidth/14.72 + xOffset*xRelIndex
            let yImageCenter:Double = screenHeight/16.22 + yOffset*yRelIndex

            // Get the tile from the hand
            let tile = winningHand.tiles[index]
            let key = "\(tile.getRawValue())"

            if let image = imageDictionary[key] {
                // Get the image from the dictionary, and create the image
                let newImage = rescaleImage(image!, width: imageWidth, height: imageHeight)
                let imageView = UIImageView(image: newImage)
                imageView.center = CGPoint(x: xImageCenter, y: yImageCenter)
                imageView.userInteractionEnabled = true

                // Add tap handler to listen for deletes
                let recognizer = UITapGestureRecognizer(target: self, action:Selector("handTileTapped:"))
                recognizer.delegate = self
                imageView.addGestureRecognizer(recognizer)
                imageView.accessibilityLabel = "\(index)"

                HandImages.addSubview(imageView)

                if tile.wait {
                    // Add red dot above tile to represent a wait
                    let redDot = UIImage(named: "RedDot.png")
                    let redView = UIImageView(image: redDot)

                    let xRedCenter:Double = screenWidth/29 + xRedOffset*xRelIndex
                    let yRedCenter:Double = yRedOffset*yRelIndex - screenHeight/37.87

                    redView.frame = CGRect(x:xRedCenter, y:yRedCenter, width: 12, height: 12)

                    imageView.addSubview(redView)
                }
            }
        }
    }

    // Clear all images of the tiles in hand added from the view
    func clearAllSubViews() {
        for view in HandImages.subviews {
            view.removeFromSuperview()
        }
    }

    // Helper function to rescale image to correct size.
    // Adapted from: https://gist.github.com/hcatlin/180e81cd961573e3c54d
    func rescaleImage(image: UIImage, width: Double, height: Double) -> UIImage {
        var newSize:CGSize = CGSize(width: width, height: height)
        let rect = CGRectMake(0,0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)

        image.drawInRect(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

    // Deletes hand tile when tapped on
    func handTileTapped(sender: UITapGestureRecognizer) {
        if let message:String = sender.view?.accessibilityLabel {
            if let index:Int = message.toInt() {
                winningHand.removeTile(index)
                updateHandImage()
            }
        }
    }
}
