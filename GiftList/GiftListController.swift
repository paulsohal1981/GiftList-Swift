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
    
    var events = []
    var gifts : [Gift] = []
    var selectedGift : Gift? = nil
    var dataContext = DataContext()
    
    let giftDetailSegueName = "giftDetailSegue"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        
        //Add background to table view
        self.tableView.rowHeight = 200
        
        //self.tableView.backgroundView = UIImageView(image: UIImage(named: "light_blue_mini_dots_on_sky_blue"))
        
        
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
    }

    
    //TABLE View Functions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.gifts.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var gift = self.gifts[indexPath.row] as Gift
        
        var cell = UITableViewCell();
        
        cell.textLabel!.text = gift.name
        cell.imageView?.image = UIImage(data: gift.frontImage)
        
        cell.imageView?.transform = CGAffineTransformMakeScale(0.65, 0.65);
        
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

}

