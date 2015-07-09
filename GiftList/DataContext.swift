//
//  DataContext.swift
//  GiftList
//
//  Created by paul sohal on 6/18/15.
//  Copyright (c) 2015 Acceler Inc. All rights reserved.
//

import UIKit
import CoreData

class DataContext {
    
    var GiftEntity = "Gift";
    var EventEntity = "Event";
    
    var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!

    //Insert
    func InsertGift(name: String, uiImageName: String)
    {
        
        var newGift = NSEntityDescription.insertNewObjectForEntityForName("Gift", inManagedObjectContext: context) as! Gift
        
        //Map incoming gift to new gift
        
        newGift.name = name
        newGift.frontImage = UIImageJPEGRepresentation(UIImage(named: uiImageName), 1)
//        newGift.backImage = gift.backImage
        
        self.context.save(nil)
        
    }
    
    //Insert with Front and Back Image
    func InsertGiftWithFrontandBackImage(name: String, frontImage: NSData, backImage: NSData)
    {
        var newGift = NSEntityDescription.insertNewObjectForEntityForName("Gift", inManagedObjectContext: context) as! Gift
        
        //Map incoming gift to new gift
        
        newGift.name = name
        newGift.frontImage = frontImage
        newGift.backImage = backImage
        newGift.createdDate = NSDate()
        
        
        self.context.save(nil)
        
    }
    
    func DeleteGift(gift: Gift)
    {
        
        self.context.deleteObject(gift)
        self.context.save(nil)
    }
    
    func GetAllGifts() -> [Gift]
    {
        var gifts:[Gift] = []
        
        var request = NSFetchRequest(entityName: self.GiftEntity)
        
        var results = self.context.executeFetchRequest(request, error: nil)
        
        if results != nil
        {
            gifts = results! as! [Gift]
        }
        
        return gifts;
    }
    
    

}
