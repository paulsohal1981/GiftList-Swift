//
//  ImageDetailController.swift
//  GiftList
//
//  Created by paul sohal on 7/6/15.
//  Copyright (c) 2015 Acceler Inc. All rights reserved.
//

import UIKit

class ImageDetailController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let dayTimePeriodFormatter = NSDateFormatter()
    let dataContext = DataContext()

    
    var gift : Gift? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize formatter
        dayTimePeriodFormatter.dateFormat = "MMMM d, y"
        
        //Set Image
        self.detailImage.image = UIImage(data: self.gift!.frontImage)
        
        //Set Label
        self.imageLabel.text = self.gift!.name
        
        //Set Date
        self.dateLabel.text = dayTimePeriodFormatter.stringFromDate(self.gift!.createdDate)
        
        //Add Gesture
        let frontTapRecoginzer = UITapGestureRecognizer(target: self, action: "frontTapped")
        
        //Add tap even to front image view
        self.detailImage.addGestureRecognizer(frontTapRecoginzer)
        
    }
    
    @IBAction func deleteGift(sender: AnyObject) {
        //Delete the image
        self.dataContext.DeleteGift(gift!)
        
        //Pop this view
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func shareButtonClicked(sender: AnyObject) {
        let textToShare = "Thank you for the gift, \(gift!.name)!"
        
        //if let myWebsite = NSURL(string: "http://www.codingexplorer.com/")
            if let myImage = UIImage(data: self.gift!.frontImage)
        {
            let objectsToShare = [textToShare, myImage]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList,UIActivityTypeAssignToContact]
            
            activityVC.completionWithItemsHandler = doneSharingHandler
            
            self.presentViewController(activityVC, animated: true, completion: nil)
            
            
            //Pop this view
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func frontTapped()
    {
        
        //Initiate Segue
        //self.performSegueWithIdentifier("zoomDetailSegue", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //Initiate Segue
        let imageZoomController = segue.destinationViewController as! ImageZoomController
        
        imageZoomController.image = self.detailImage.image
        
    }
    func doneSharingHandler(activityType: String?, completed: Bool, returnedItems: [AnyObject]?, error: NSError?) {
        // Return if cancelled
        if (!completed) {
            return
        }
        else
        {
            CompleteThanks()
        }
        
    }
    
    func CompleteThanks()
    {
        
        gift?.thanked = "1"
        gift?.thankedDate = NSDate()
        dataContext.SetThanked(gift!)
    }
    
}
