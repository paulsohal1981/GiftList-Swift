//
//  GiftCustomCell.swift
//  GiftList
//
//  Created by paul sohal on 7/10/15.
//  Copyright (c) 2015 Acceler Inc. All rights reserved.
//

import UIKit

class GiftCustomCell : UITableViewCell {
    
    @IBOutlet weak var giftImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func thankSelected(sender: AnyObject) {
        let textToShare = "Thank you for the gift!"
        
        //if let myWebsite = NSURL(string: "http://www.codingexplorer.com/")
        if let myImage = self.giftImage.image
        {
            let objectsToShare = [textToShare, myImage]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
            
            
            //self.presentViewController(activityVC, animated: true, completion: nil)
            
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    
}
