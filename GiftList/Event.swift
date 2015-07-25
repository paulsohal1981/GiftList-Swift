//
//  Event.swift
//  Papoose
//
//  Created by paul sohal on 7/25/15.
//  Copyright (c) 2015 Acceler Inc. All rights reserved.
//

import Foundation
import CoreData

class Event: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var createdDate: NSDate
    @NSManaged var eventId: String
}
