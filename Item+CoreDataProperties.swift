//
//  Item+CoreDataProperties.swift
//  ShoppingList
//
//  Created by Jeff Norton on 7/8/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item {

    @NSManaged var name: String
    @NSManaged var quantity: NSNumber
    @NSManaged var dueDate: NSDate
    @NSManaged var havePurchased: NSNumber

}
