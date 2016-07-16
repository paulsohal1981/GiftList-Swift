//
//  CreateNewGiftController.swift
//  GiftList
//
//  Created by paul sohal on 6/23/15.
//  Copyright (c) 2015 Acceler Inc. All rights reserved.
//

import Foundation
import UIKit
import StoreKit


class CreateNewGiftController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var cameraImageView: UIImageView!
    var dataContext = DataContext()
    var isFrontPicture : Bool = true
    var userSettings : UserSettings? = nil
    
    let productIdentifiers = Set([Settings.inAppProductId])
    var product: SKProduct?
    var productsArray = Array<SKProduct>()
    
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var GiftName: UITextField!
    @IBOutlet weak var testView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create a tapGesture for the image
        let frontTapRecoginzer = UITapGestureRecognizer(target: self, action: "frontTapped")
        
        //Add tap even to front image view
        self.frontImage.addGestureRecognizer(frontTapRecoginzer)
        //self.backImage.addGestureRecognizer(backTapRecognizer)
        
        self.userSettings = dataContext.GetUserSettings();
        

    }
    
    override func viewWillAppear(animated: Bool) {
        
        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: "Create New Gift")
        
        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        
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
        
        let frontUIImage = UIImageJPEGRepresentation(self.frontImage.image!, 1)
        let backUIImage = UIImageJPEGRepresentation(self.frontImage.image!, 1)
    
        self.dataContext.InsertGiftWithFrontandBackImage(self.GiftName.text!, frontImage: frontUIImage! , backImage: backUIImage!)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    
}
