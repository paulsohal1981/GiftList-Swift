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
        
        return cell;
    }
    
    //Select Row
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedGift = self.gifts[indexPath.row] as Gift
        //self.performSegueWithIdentifier(self.giftDetailSegueName, sender: self)
        
        self.performSegueWithIdentifier("imageDetailSegue", sender: self)

    }
    
    //Segue pass gift object
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == self.giftDetailSegueName
        {
        
            var detailGiftController = segue.destinationViewController as! GiftDetailViewController
        
            detailGiftController.gift = self.selectedGift
            
        }
        
        if( segue.identifier == "imageDetailSegue")
        {
            var detailGiftController = segue.destinationViewController as! ImageDetailController
            
            detailGiftController.gift = self.selectedGift
        }
        
        
    }

}

