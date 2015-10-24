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
    var userSettings : UserSettings? = nil
    
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var GiftName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create a tapGesture for the image
        let frontTapRecoginzer = UITapGestureRecognizer(target: self, action: "frontTapped")
        
        //Add tap even to front image view
        self.frontImage.addGestureRecognizer(frontTapRecoginzer)
        //self.backImage.addGestureRecognizer(backTapRecognizer)
        
        self.userSettings = dataContext.GetUserSettings();
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    //Call Camera
    func callCamera()
    {
        //Check to see if device has a camera
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            let cameraViewController = UIImagePickerController()
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
        
        let gifts = dataContext.GetAllGifts();
        if(gifts.count > Int(self.userSettings!.giftcount))
        {
            let alert = UIAlertController(title: "Congratulation", message: "We're glad you enjoy using Papoose. To continue adding unlimited gifts, please unlock the forver gift feature.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            let frontUIImage = UIImageJPEGRepresentation(self.frontImage.image!, 1)
            let backUIImage = UIImageJPEGRepresentation(self.frontImage.image!, 1)
        
            self.dataContext.InsertGiftWithFrontandBackImage(self.GiftName.text!, frontImage: frontUIImage! , backImage: backUIImage!)
        
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}
