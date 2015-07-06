//
//  CreateNewGiftController.swift
//  GiftList
//
//  Created by paul sohal on 6/23/15.
//  Copyright (c) 2015 Acceler Inc. All rights reserved.
//

import Foundation
import UIKit

class CreateNewGiftController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    var dataContext = DataContext()
    var isFrontPicture : Bool = true

    
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var GiftName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create a tapGesture for the image
        var frontTapRecoginzer = UITapGestureRecognizer(target: self, action: "frontTapped")
        var backTapRecognizer = UITapGestureRecognizer(target: self, action: "backTapped")
        
        
        //Add tap even to front image view
        self.frontImage.addGestureRecognizer(frontTapRecoginzer)
        //self.backImage.addGestureRecognizer(backTapRecognizer)
    }
    
    //Tap Events
    func frontTapped()
    {
        self.callCamera()
        //Open camera
    }
    
    func backTapped()
    {
        self.isFrontPicture = false
        
        self.callCamera()
        //Open Camera
    }
    
    
    //Call Camera
    func callCamera()
    {
        //Check to see if device has a camera
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            var cameraViewController = UIImagePickerController()
            cameraViewController.sourceType = UIImagePickerControllerSourceType.Camera
            cameraViewController.delegate = self
            
            self.presentViewController(cameraViewController, animated: true, completion: nil)
        }
        
    }
    
    //Camera finished
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        if(self.isFrontPicture)
        {
         self.frontImage.image = image
        }
        
        else
        {
         //self.backImage.image = image
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Cancel Button
    //Close Modal
    @IBAction func CancelNewGift(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true
            , completion: nil)
    }
    
    //Save Button
    @IBAction func SaveNewGift(sender: AnyObject) {
        var frontUIImage = UIImageJPEGRepresentation(self.frontImage.image, 1)
        var backUIImage = UIImageJPEGRepresentation(self.frontImage.image, 1)
        
        self.dataContext.InsertGiftWithFrontandBackImage(self.GiftName.text, frontImage: frontUIImage , backImage: backUIImage)
        
        self.dismissViewControllerAnimated(true
            , completion: nil)
    }
    
}
