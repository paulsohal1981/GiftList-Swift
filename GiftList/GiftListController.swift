//
//  ViewController.swift
//  GiftList
//
//  Created by paul sohal on 6/18/15.
//  Copyright (c) 2015 Acceler Inc. All rights reserved.
//

import UIKit
import CoreData

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
        var nib = UINib(nibName: "GiftTableCellView", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        
        //initialize formatter
        dayTimePeriodFormatter.dateFormat = "MMMM d, y"
        
        self.loadGifts()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //Load Gifts
        self.loadGifts()
        
        //rebind data list
        self.tableView.reloadData()
        
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

    
    //TABLE View Functions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.gifts.count;
    }
    
    //Set Cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var gift = self.gifts[indexPath.row] as Gift
        
        var cell:GiftCustomCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! GiftCustomCell
        
        cell.gift = gift
        cell.giftImage?.image = UIImage(data: gift.frontImage)
        cell.name!.text = gift.name
        cell.date!.text = dayTimePeriodFormatter.stringFromDate(gift.createdDate)
        
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
            var gift = self.gifts[indexPath.row]
            self.gifts.removeAtIndex(indexPath.row)
            
            //Delete the image
            self.dataContext.DeleteGift(gift)
            
            //Delete the row in the table view
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    //Segue pass gift object
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if( segue.identifier == "imageDetailSegue")
        {
            var detailGiftController = segue.destinationViewController as! ImageDetailController
            
            detailGiftController.gift = self.selectedGift
        }
        
        
    }

    @IBAction func addGift(sender: AnyObject)
    {
        performSegueWithIdentifier("addGiftSegue", sender: sender)
    }
}

