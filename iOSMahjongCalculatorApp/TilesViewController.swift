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
    @IBOutlet weak var ChiButton: UIButton!
    @IBOutlet weak var PonButton: UIButton!
    @IBOutlet weak var KanButton: UIButton!
    @IBOutlet weak var ClosedKanButton: UIButton!

    var winningHand:Hand!
    var values = lookUp
    var images = imageDictionary
    var status = Status.None

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
            if let (value:Value, suit:Suit) = values[message] {
                let tile:Tile = Tile(value: value, suit: suit)
                if status == .None {
                    winningHand.addTile(tile)
                    status = .None
                } else {
                    winningHand.addMeld(tile, status:status)
                    status = .None
                }
                updateHandImage()
                setButtonColors()
            }
        }
    }

    @IBAction func chiTapped(sender: UIButton) {
        status = (status != .Chi) ? .Chi : .None
        setButtonColors()
    }

    @IBAction func ponTapped(sender: UIButton) {
        status = (status != .Pon) ? .Pon : .None
        setButtonColors()
    }

    @IBAction func kanTapped(sender: UIButton) {
        status = (status != .Kan) ? .Kan : .None
        setButtonColors()
    }

    @IBAction func closedKanTapped(sender: UIButton) {
        status = (status != .ClosedKan) ? .ClosedKan : .None
        setButtonColors()
    }

    func setButtonColors() {
        if status == .Chi {
            ChiButton.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        } else {
            ChiButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        }

        if status == .Pon {
            PonButton.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        } else {
            PonButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        }

        if status == .Kan {
            KanButton.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        } else {
            KanButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        }

        if status == .ClosedKan {
            ClosedKanButton.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        } else {
            ClosedKanButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        }
    }

    // When clear button is tapped, remove all dora tiles from hand
    @IBAction func clearTapped(button:UIButton) {
        winningHand.removeAllTiles()
        clearAllSubViews()
        status = Status.None
        setButtonColors()
    }

    // Dismisses view controller to return to this controller
    @IBAction func cancelToTilesViewController(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func getSecondaryImage(tile:Tile) -> UIImage {
        if tile.wait {
            return UIImage(named: "RedDot.png")!
        }

        switch tile.status {
        case Status.Chi:
            return UIImage(named: "C.png")!
        case Status.Pon:
            return UIImage(named: "P.png")!
        case Status.Kan:
            return UIImage(named: "K.png")!
        case Status.ClosedKan:
            return UIImage(named: "CK.png")!
        default:
            return UIImage(named: "Default.png")!
        }
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
        let xImageOffset:Double = screenWidth/1600
        let yImageOffset:Double = screenHeight/400

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
                var newImage = rescaleImage(image!, width: imageWidth, height: imageHeight)
                
                let imageView = UIImageView(image: newImage)
                imageView.center = CGPoint(x: xImageCenter, y: yImageCenter)
                imageView.userInteractionEnabled = true

                // Add tap handler to listen for deletes
                let recognizer = UITapGestureRecognizer(target: self, action:Selector("handTileTapped:"))
                recognizer.delegate = self
                imageView.addGestureRecognizer(recognizer)
                imageView.accessibilityLabel = "\(index)"

                HandImages.addSubview(imageView)

                if tile.wait || tile.status != Status.None {
                    // Add red dot above tile to represent a wait
                    let image = getSecondaryImage(tile)
                    let view = UIImageView(image: image)

                    let xCenter:Double = screenWidth/29 + xImageOffset*xRelIndex
                    let yCenter:Double = yImageOffset*yRelIndex - screenHeight/37.87

                    view.frame = CGRect(x:xCenter, y:yCenter, width: 12, height: 12)

                    imageView.addSubview(view)
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
                let tile = winningHand.tiles[index]
                if tile.status == .Pon || tile.status == .Kan || tile.status == .ClosedKan {
                   winningHand.removeAllOfTile(tile)
                } else {
                   winningHand.removeTileAtIndex(index)
                }
                updateHandImage()
                setButtonColors()
            }
        }
    }
}
