//
//  ItemListTableViewController.swift
//  ShoppingList
//
//  Created by Jeff Norton on 7/8/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ItemListTableViewController: UITableViewController, ItemPurchasedDelegate {

    // MARK: - Stored Properties
    
    @IBOutlet weak var addItemButton: UIBarButtonItem!
    
    let defaultQuantity = 1
    let defaultDueDate = NSDate(timeIntervalSinceNow: 604800)       // 604800 = number of seconds in one week
    
    
    // MARK: - General
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Action(s)
    
    @IBAction func addItemButtonTapped(sender: UIBarButtonItem) {
        
        // Create a welcome notification
        
        let localNotification = UILocalNotification()
        
        localNotification.category = "item_welcome"
        localNotification.alertTitle = "Shopping Items App"
        localNotification.alertBody = "Welcome to the Shopping Items app.  We hope you enjoy it.  :)"
        localNotification.alertAction = "Start Shopping"
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 30)
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        // Do add work
        
        let addItemMessage = "Please add an item to your shopping list"
        let notificationMessage = "\n\nIf you close the app within 30 seconds of seeing this app for the first time you'll get a welcome notification.  :)"
        
        let addItemAlertController = UIAlertController(title: "Add Item", message: "\(addItemMessage)\(notificationMessage)", preferredStyle: .Alert)
        
        addItemAlertController.addTextFieldWithConfigurationHandler { textField in
            
            textField.text = ""
            
        }
        
        let addItemAction = UIAlertAction(title: "Add", style: .Default) { (action) in
            
            guard let itemTextField = (addItemAlertController.textFields?[0]), itemName = itemTextField.text else { return }
            
            if itemName.characters.count > 0 {
                ItemController.sharedController.addItem(itemName, quantity: self.defaultQuantity, dueDate: self.defaultDueDate)
                
                self.tableView.reloadData()
            }
            
        }
        
        let cancelItemAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        addItemAlertController.addAction(addItemAction)
        addItemAlertController.addAction(cancelItemAction)
        
        presentViewController(addItemAlertController, animated: true, completion: nil)
    }
    
    
    // MARK: - ItemPurchasedDelegate
    
    func havePurchasedStateChangeInitiated(cell: ItemTableViewCell) {
        
        // Diagnostics
        
        print("Items breakdown:")
        print("\ttotal items purchased: \(ItemController.sharedController.purchasedItems.count)")
        print("\ttotal items not purchased: \(ItemController.sharedController.unpurchasedItems.count)")
        
        // Change work
        
//        guard let index = tableView.indexPathForCell(cell)?.row else { return }
        
        guard let indexPath = tableView.indexPathForCell(cell) else { return }
        
        let item = ItemController.sharedController.items[indexPath.row]
        
        print("Item (before update): index = \(index), name = \(item.name), havePurchased = \(item.havePurchased)")
        
        ItemController.sharedController.toggleHavePurchased(item)
        
        // Get the updated item
        let updatedItem = ItemController.sharedController.items[indexPath.row]
        
        cell.updateWith(updatedItem)
        
        print("Item (after update): index = \(index), name = \(item.name), havePurchased = \(item.havePurchased)")
        
        tableView.beginUpdates()
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.endUpdates()
    }
    

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.sharedController.items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCellWithIdentifier("itemTableCell", forIndexPath: indexPath) as? ItemTableViewCell else { return UITableViewCell() }

        let item = ItemController.sharedController.items[indexPath.row]
        
        cell.updateWith(item)
        cell.delegate = self
        
        print("Item: index = \(index), name = \(item.name), havePurchased = \(item.havePurchased)")

        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
          
            let item = ItemController.sharedController.items[indexPath.row]
            
            ItemController.sharedController.removeItem(item)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    

}
