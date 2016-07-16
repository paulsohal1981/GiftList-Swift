//
//  ViewController.swift
//  GiftList
//
//  Created by paul sohal on 6/18/15.
//  Copyright (c) 2015 Acceler Inc. All rights reserved.
//

import UIKit
import CoreData
import StoreKit
import SwiftyStoreKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addGiftButton: UIButton!
    
    var events = []
    var gifts : [Gift] = []
    var selectedGift : Gift? = nil
    var dataContext = DataContext()

    let giftDetailSegueName = "giftDetailSegue"
    let dayTimePeriodFormatter = NSDateFormatter()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        
        //Add background to table view
        self.tableView.rowHeight = 200
        //self.tableView.contentInset = UIEdgeInsetsZero
        self.tableView.contentInset = UIEdgeInsetsMake(55, 0, 0, 0);
        
        //Register the custom cell
        let nib = UINib(nibName: "GiftTableCellView", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        
        //initialize formatter
        dayTimePeriodFormatter.dateFormat = "MMMM d, y"
        
        //SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        
        
        self.loadGifts()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //Load Gifts
        self.loadGifts()
        
        //rebind data list
        self.tableView.reloadData()
        
        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: "Gift List")
        
        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        
    }
    
    
    //Load Events
    func loadGifts()
    {
        self.gifts = self.dataContext.GetAllGifts()
        
        
        if(self.gifts.count == 0)
        {
            addGiftButton.hidden = false;
            tableView.hidden = true
        }
        else
        {
            addGiftButton.hidden = true;
            tableView.hidden = false;
        }
        
    }

    @IBAction func resetInAppPurchaseClick(sender: AnyObject) {
        showResetInAppPurchaseAlert()
    }
    
    func showResetInAppPurchaseAlert()
    {
        //Create the AlertController
        let actionSheetController: UIAlertController =  UIAlertController(title: "Restore In-App Purchase", message: "Restore your In-App purchase and unlock the ability to manage unlimited gifts", preferredStyle: .ActionSheet)

        //Continue action
        let continueAction: UIAlertAction = UIAlertAction(title: "Restore", style: .Default) { action -> Void in
            actionSheetController.dismissViewControllerAnimated(false, completion: nil)
            
            SwiftyStoreKit.restorePurchases() { result in
                switch result {
                case .Success(let productId):
                    print("Restore Success: \(productId)")
                    self.dataContext.SetUserSettingGiftCount(10000)
                    self.alert("Congratulations", message: "Your purchas has been restored!")
                    print("Gift Count Set to 10000")
                    break
                case .NothingToRestore:
                    print("Nothing to Restore")
                    self.alert("Nothing to Restore", message: "Nothing to Restore")

                    break
                case .Error(let error):
                    print("Restore Failed: \(error)")
                    self.alert("Error", message: "Restore Failed: \(error)")
    
                    break
                }
            }
        }
        
        //Continue action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            actionSheetController.dismissViewControllerAnimated(false, completion: nil)
        }
        
        actionSheetController.addAction(continueAction)
        actionSheetController.addAction(cancelAction)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    //TABLE View Functions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.gifts.count;
    }
    
    //Set Cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let gift = self.gifts[indexPath.row] as Gift
        
        let cell:GiftCustomCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! GiftCustomCell
        
        cell.gift = gift
        cell.giftImage?.image = UIImage(data: gift.frontImage)
        cell.name!.text = gift.name
        cell.date!.text = dayTimePeriodFormatter.stringFromDate(gift.createdDate)
        cell.delegate = self;
        
       // println(gift.thanked)
        
        if(gift.thanked == "1")
        {
            cell.thankButton.hidden = true
            cell.thankedOnLabel.hidden = false
            cell.thankedOnLabel!.text = "Thanked on " + dayTimePeriodFormatter.stringFromDate(gift.thankedDate)
        }
        else
        {
            cell.thankedOnLabel.hidden = true
            cell.thankButton.hidden = false
        }
        
        
        return cell;
    }
    
    //Select Row
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedGift = self.gifts[indexPath.row] as Gift
        //self.performSegueWithIdentifier(self.giftDetailSegueName, sender: self)
        
        self.performSegueWithIdentifier("imageDetailSegue", sender: self)

    }
    
    //Edit Row
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            let gift = self.gifts[indexPath.row]
            self.gifts.removeAtIndex(indexPath.row)
            
            //Delete the image
            self.dataContext.DeleteGift(gift)
            
            //Delete the row in the table view
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])   {
        
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .Restored:
                
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
    
    //Segue pass gift object
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if( segue.identifier == "imageDetailSegue")
        {
            let detailGiftController = segue.destinationViewController as! ImageDetailController
            
            detailGiftController.gift = self.selectedGift
        }
        
        
    }

    @IBAction func addGift(sender: AnyObject)
    {
        performSegueWithIdentifier("addGiftSegue", sender: sender)
    }
    
    func alert(title: String, message: String)
    {
        //Create the AlertController
        let actionSheetController: UIAlertController =  UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        //Continue action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Okay", style: .Cancel) { action -> Void in
            actionSheetController.dismissViewControllerAnimated(false, completion: nil)
        }
        
        actionSheetController.addAction(cancelAction)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)

    }
    

}

