//
//  ParseAnalyticUtility.swift
//  Papoose
//
//  Created by paul sohal on 9/3/15.
//  Copyright (c) 2015 Acceler Inc. All rights reserved.
//

import Foundation
import Parse

class ParseAnalyticUtility {
    
    func AddPhoto(button:String)
    {
        
        let dimensions = [
            // Where the addPhoto is happening
            "button": button,
        ]
        // Send the dimensions to Parse along with the 'search' event
        PFAnalytics.trackEvent("addPhoto", dimensions:dimensions);
        
    }
    
    func SavePhoto(button:String, hasName:String, hasPhoto: String)
    {
        let dimensions = [
            // Where the addPhoto is happening
            "button": button,
            "hasName": hasName,
            "hasPhoto": hasPhoto
        ]
        // Send the dimensions to Parse along with the 'search' event
        PFAnalytics.trackEvent("savePhoto", dimensions:dimensions);
    }
    
    func ThanksStart(page:String)
    {
        let dimensions = [
            // Page where thanks is happening
            "page": page
        ]
        // Send the dimensions to Parse along with the 'search' event
        PFAnalytics.trackEvent("thanksStart", dimensions:dimensions);
    }
    
    func ThanksComplete(page:String, type:String)
    {
        let dimensions = [
            // Where the addPhoto is happening
            "button": page,
            //Type of thanks sms|email|facebook|twiiter
            "hasName": type
        ]
        // Send the dimensions to Parse along with the 'search' event
        PFAnalytics.trackEvent("thanksComplete", dimensions:dimensions);
    }
    
    func TourStarted()
    {

        //Tour has Started
        PFAnalytics.trackEvent("tourStarted");
    }
    
    func TourEnded()
    {
        // User Closed the Tour
        PFAnalytics.trackEvent("tourEnded");
        
    }
    
}