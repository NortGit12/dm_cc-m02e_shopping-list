//
//  Item.swift
//  ShoppingList
//
//  Created by Jeff Norton on 7/8/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData


class Item: NSManagedObject {

    convenience init(name: String, quantity: Int = 1, dueDate: NSDate = NSDate(), havePurchased: Bool, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.quantity = quantity
        self.dueDate = dueDate
        self.havePurchased = havePurchased
        
    }

}
