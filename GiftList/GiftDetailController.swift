//
//  GiftDetailController.swift
//  GiftList
//
//  Created by paul sohal on 6/18/15.
//  Copyright (c) 2015 Acceler Inc. All rights reserved.
//

import Foundation
import UIKit

class GiftDetailViewController: UIViewController {
    
    
    @IBOutlet weak var mailImage: UIImageView!
    
    var gift : Gift? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Set Title
        self.navigationItem.title = self.gift!.name
        
        //Set Image
        self.mailImage.image = UIImage(data: self.gift!.frontImage)
        
        var frontTapRecoginzer = UITapGestureRecognizer(target: self, action: "frontTapped")
        
        
        //Add tap even to front image view
        self.mailImage.addGestureRecognizer(frontTapRecoginzer)
        
    }
    
    
    func frontTapped()
    {
        
        //Initiate Segue
        self.performSegueWithIdentifier("zoomSegue", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var imageZoomController = segue.destinationViewController as! ImageZoomController
        
        imageZoomController.image = self.mailImage.image
        
    }
    
    
}