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

class CreateNewGiftController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create a tapGesture for the image
        let frontTapRecoginzer = UITapGestureRecognizer(target: self, action: "frontTapped")
        
        //Add tap even to front image view
        self.frontImage.addGestureRecognizer(frontTapRecoginzer)
        //self.backImage.addGestureRecognizer(backTapRecognizer)
        
        self.userSettings = dataContext.GetUserSettings();
        
        // Set IAPS
        requestProductData()
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        
       
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
            buyUnlimitedGift()
        }
        else
        {
            let frontUIImage = UIImageJPEGRepresentation(self.frontImage.image!, 1)
            let backUIImage = UIImageJPEGRepresentation(self.frontImage.image!, 1)
        
            self.dataContext.InsertGiftWithFrontandBackImage(self.GiftName.text!, frontImage: frontUIImage! , backImage: backUIImage!)
        
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    //Initiates a Request to recieve Product Data
    func requestProductData()
    {
        //Check to see if user can make a payment
        if SKPaymentQueue.canMakePayments() {
            
            //Send a request to app store to get the products.
            let request = SKProductsRequest(productIdentifiers: self.productIdentifiers)
            request.delegate = self
            request.start()
            
        } else {
            let alert = UIAlertController(title: "In-App Purchases Not Enabled", message: "Please enable In App Purchase in Settings", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default, handler: { alertAction in
                alert.dismissViewControllerAnimated(true, completion: nil)
                
                let url: NSURL? = NSURL(string: UIApplicationOpenSettingsURLString)
                if url != nil
                {
                    UIApplication.sharedApplication().openURL(url!)
                }
                
            }))
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { alertAction in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func buyUnlimitedGift() {
        let payment = SKPayment(product: product!)
        SKPaymentQueue.defaultQueue().addPayment(payment)
    }
    
    //Request for product is recieved and products are set in the controller.
    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        
        var products = response.products
        
        if (products.count != 0) {
            for var i = 0; i < products.count; i++
            {
                self.product = products[i]
                self.productsArray.append(product!)
            }
           
        } else {
            print("No products found")
        }
        
    }
    
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])   {
       
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .Purchased:
                        dataContext.SetUserSettingGiftCount(10000)
                    break;
                case .Failed:

                    break;
                    // case .Restored:
                    //[self restoreTransaction:transaction];
                default:
                    break;
                }
            }
        }
    }
    
    
}
