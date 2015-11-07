//
//  ClientAPI.swift
//  Papoose
//
//  Created by paul sohal on 11/7/15.
//  Copyright © 2015 Acceler Inc. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ClientAPI: NSObject {
    
    let token = Utility().EncodeBase64(Settings.handWrittenNotesKey + ":" + Settings.handWrittenNotesSecret)
    
    override init() {
      
    }
    
    func getHandWrittenNote(message: String, callback: (image:UIImage) -> ())
    {
        let headers = [
            "Authorization": "Basic " + token
            ,"Accept" : "image/png"
        ]
        
        let parameters = [
            "handwriting_id" : "5WGWVX7800WB"
            ,"handwriting_size" : "20px"
            ,"line_spacing" : "1.2"
            ,"handwriting_color" : "#1f248f"
            , "width": "400px"
            , "height" : "auto"
            ,"text" : message
        ]
        
        Alamofire.request(.GET, Settings.handWrittenApiUrl, headers: headers, parameters: parameters)
            .responseJSON { response in
                debugPrint(response)
                
                callback(image: UIImage(data: response.data!)!)
        }
    }
    

    func getHandwrittings()
    {
        let headers = ["Authorization": "Basic " + token]
        
        Alamofire.request(.GET, "https://api.handwriting.io/handwritings", headers: headers)
            .responseJSON { response in
                
                let json = JSON(response.result.value!)
                
                var fonts = Dictionary<String, String>()
                
                for (key,subJson):(String, JSON) in json {
                
                    print(subJson["id"])
                    print(subJson["title"])
                 
                }
                
        }
    }
    
}
