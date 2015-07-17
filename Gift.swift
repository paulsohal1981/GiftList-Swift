//
//  Gift.swift
//  GiftList
//
//  Created by paul sohal on 7/16/15.
//  Copyright (c) 2015 Acceler Inc. All rights reserved.
//

import Foundation
import CoreData

class Gift: NSManagedObject {

    @NSManaged var backImage: NSData
    @NSManaged var createdDate: NSDate
    @NSManaged var frontImage: NSData
    @NSManaged var name: String
    @NSManaged var thanked: NSNumber

}
