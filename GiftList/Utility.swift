//
//  Utility.swift
//  Papoose
//
//  Created by paul sohal on 11/7/15.
//  Copyright © 2015 Acceler Inc. All rights reserved.
//

import UIKit

class Utility {
    
    
    func EncodeBase64(value: String) -> String
    {
        let plainData = (value as
            NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        return base64String
    }
    
    func DecodeBase64(base64String: String) -> String
    {
        let decodedData = NSData(base64EncodedString: base64String, options:NSDataBase64DecodingOptions(rawValue: 0))
        let decodedString = NSString(data: decodedData!, encoding: NSUTF8StringEncoding)
        
        return decodedString as! String
    }
    
}