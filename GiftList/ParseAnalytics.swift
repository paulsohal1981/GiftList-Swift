//
//  ParseAnalytics.swift
//  Papoose
//
//  Created by paul sohal on 1/18/16.
//  Copyright © 2016 Acceler Inc. All rights reserved.
//

class ParseAnalytics {
    
    
    //Tour Completed - KPI
    static func TourCompleted()
    {
        let dimensions = [
            // Tour compmleted
            "TourCompleted": "1"
        ]
        
        // Send the dimensions to Parse along with the 'search' event
            }
    
    
    //Gift Added - KPI
    static func GiftAdded(giver: String)
    {
        let dimensions = [
            // Description
            "Giver" : giver
        ]
        
        // Send the dimensions to Parse along with the 'search' event
        
    }
    
    //Purchase Shown
    static func PurchaseShown()
    {
        let dimensions = [
            
            "Shown": "1",
        ]
        
        
    }
    
    
    //Purchase Complete
    static func PurchaseComplete()
    {
        let dimensions = [
            
            "Complete": "1",
        ]
        
        // Send the dimensions to Parse along with the 'search' event
        
    }
    
    //Thanked
    static func Thanked(age: String, type: String)
    {
        let dimensions = [
            
            "Age": age,
            "Type": type
        ]
        
        // Send the dimensions to Parse along with the 'search' event
        
    }
    
    
}