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
        
    }
    
}
