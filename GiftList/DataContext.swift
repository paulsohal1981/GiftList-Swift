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
    var UserSettingsEntity = "UserSettings";
    
    var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!

    //UserSettings
    func GetUserSettings() -> UserSettings
    {
        //Request Entity
        let request = NSFetchRequest(entityName: self.UserSettingsEntity);
        
        do
        {
        //let results = try? self.context.executeFetchRequest(request)
            let results = (try! self.context.executeFetchRequest(request)) as! [UserSettings]
            
            if (results.count == 0)
            {
                let newSetting = NSEntityDescription.insertNewObjectForEntityForName(self.UserSettingsEntity, inManagedObjectContext: context) as! UserSettings
                
                newSetting.giftcount = 10;
                
                do {
                    try self.context.save()
                } catch _ {
                }
                
                return newSetting;
            }
            else
            {
                
            }
            
            return results[0];
        }
        catch _{
            
        }
      
    }
    
    func SetUserSettingGiftCount(count: Int16)
    {
        var setting = GetUserSettings();
        setting.giftcount = count;
        
        do {
            try self.context.save()
        } catch _ {
        }
        
    }
    
    //Insert
    func InsertGift(name: String, uiImageName: String)
    {
        
        let newGift = NSEntityDescription.insertNewObjectForEntityForName("Gift", inManagedObjectContext: context) as! Gift
        
        //Map incoming gift to new gift
        
        newGift.name = name
        newGift.frontImage = UIImageJPEGRepresentation(UIImage(named: uiImageName)!, 1)!
        do {
            //        newGift.backImage = gift.backImage
        
            try self.context.save()
        } catch _ {
        }
    }
    
    //Insert with Front and Back Image
    func InsertGiftWithFrontandBackImage(name: String, frontImage: NSData, backImage: NSData)
    {
        let newGift = NSEntityDescription.insertNewObjectForEntityForName("Gift", inManagedObjectContext: context) as! Gift
        
        //Map incoming gift to new gift
        
        newGift.name = name
        newGift.thanked = "0"
        newGift.frontImage = frontImage
        newGift.backImage = backImage
        newGift.createdDate = NSDate()
        
        
        do {
            try self.context.save()
        } catch _ {
        }
        
    }
    
    
    func DeleteGift(gift: Gift)
    {
        
        self.context.deleteObject(gift)
        do {
            try self.context.save()
        } catch _ {
        }
    }
    
    func SetThanked(gift: Gift)
    {
        print(gift.objectID)
        //Request Entity
        let request = NSFetchRequest(entityName: self.GiftEntity)
        let predicate = NSPredicate(format: "createdDate == %@", gift.createdDate)
        
        request.predicate = predicate
        
        let fetchedEntities = (try! self.context.executeFetchRequest(request)) as! [Gift]
        
        fetchedEntities.first?.thanked = gift.thanked
        fetchedEntities.first?.thankedDate = gift.thankedDate
     
        do {
            try self.context.save()
        } catch _ {
        }
    }
    
    func GetAllGifts() -> [Gift]
    {
        var gifts:[Gift] = []
        
        //Request Entity
        let request = NSFetchRequest(entityName: self.GiftEntity)
        
        //Add Sort descriptor
        request.sortDescriptors = [NSSortDescriptor(key: "createdDate", ascending: false)]
        
        let results = try? self.context.executeFetchRequest(request)
        
        if results != nil
        {
            gifts = results! as! [Gift]
        }
        
        return gifts;
    }
    
    func GetGiftByObjectId(objectId: NSManagedObjectID) -> Gift
    {
        //Request Entity
        let request = NSFetchRequest(entityName: self.GiftEntity)
        let predicate = NSPredicate(format: "objectID == %@", objectId)
        
        request.predicate = predicate
        
        let fetchedEntities = (try! self.context.executeFetchRequest(request)) as! [Gift]
        
        return fetchedEntities.first!
    }
    
    

}
