//
//  ParseAnalytics.swift
//  Papoose
//
//  Created by paul sohal on 1/18/16.
//  Copyright © 2016 Acceler Inc. All rights reserved.
//
import Parse

class ParseAnalytics {
    
    
    //Tour Completed - KPI
    static func TourCompleted()
    {
        let dimensions = [
            // Tour compmleted
            "TourCompleted": "1"
        ]
        
        // Send the dimensions to Parse along with the 'search' event
        PFAnalytics.trackEvent("compmleted", dimensions:dimensions)
    }
    
    
    //Gift Added - KPI
    static func GiftAdded(giver: String)
    {
        let dimensions = [
            // Description
            "Giver" : giver
        ]
        
        // Send the dimensions to Parse along with the 'search' event
        PFAnalytics.trackEvent("giftAdded", dimensions:dimensions)
    }
    
    //Purchase Shown
    static func PurchaseShown()
    {
        let dimensions = [
            
            "Shown": "1",
        ]
        
        // Send the dimensions to Parse along with the 'search' event
        PFAnalytics.trackEvent("purchaseShown", dimensions:dimensions)
    }
    
    
    //Purchase Complete
    static func PurchaseComplete()
    {
        let dimensions = [
            
            "Complete": "1",
        ]
        
        // Send the dimensions to Parse along with the 'search' event
        PFAnalytics.trackEvent("purchaseComplete", dimensions:dimensions)
    }
    
    //Thanked
    static func Thanked(age: String, type: String)
    {
        let dimensions = [
            
            "Age": age,
            "Type": type
        ]
        
        // Send the dimensions to Parse along with the 'search' event
        PFAnalytics.trackEvent("thanked", dimensions:dimensions)
    }
    
    
}