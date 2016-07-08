//
//  ItemController.swift
//  ShoppingList
//
//  Created by Jeff Norton on 7/8/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    
    // MARK: - Stored Properties
    
    static let sharedController = ItemController()
    
    let moc = Stack.sharedStack.managedObjectContext
    
    var items: [Item] {
        
        let request = NSFetchRequest(entityName: "Item")
        
        let items = (try? moc.executeFetchRequest(request)) as? [Item]
        
        return items ?? []
        
    }
    
    var purchasedItems: [Item] {
        
        let purchasedItems = items.filter{ item -> Bool in
            item.havePurchased.boolValue == true
        }
        
        return purchasedItems
    }
    
    var unpurchasedItems: [Item] {
        
        let unpurchasedItems = items.filter{ item -> Bool in
            
            item.havePurchased.boolValue == false
            
        }
        
        return unpurchasedItems
    }
    
    
    // MARK: - Methods (CRUD)
    
    func addItem(name: String, quantity: Int, dueDate: NSDate) {
        
        _ = Item(name: name, quantity: quantity, dueDate: dueDate, havePurchased: false)
        
        saveToPersistentStore()
    }
    
    func updateItem(item: Item, name: String, quantity: Int, dueDate: NSDate) {
        
        if name.characters.count > 0 {
            
            item.name = name
            item.quantity = quantity
            item.dueDate = dueDate
            
            saveToPersistentStore()
        }
    }
    
    func removeItem(item: Item) {
        
        moc.deleteObject(item)
        
        saveToPersistentStore()
    }
    
    
    
    // MARK: - Misc
    
    func toggleHavePurchased(item: Item) {
        
        switch item.havePurchased.boolValue {
        case true: item.havePurchased = false
        case false: item.havePurchased = true
        }
        
        saveToPersistentStore()
        
    }
    
    
    // MARK: - Persistence
    
    func saveToPersistentStore() {
        
        do {
            try moc.save()
        } catch {
            print("Error saving")
        }
        
    }
    
}