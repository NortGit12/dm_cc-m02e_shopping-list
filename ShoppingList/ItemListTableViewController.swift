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
        let notificationMessage = "If you close the app within 30 seconds you'll get a welcome notification.  :)"
        
        let addItemAlertController = UIAlertController(title: "Add Item", message: "\(addItemMessage)\n\n\(notificationMessage)", preferredStyle: .Alert)
        
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
    
    func havePurchasedStateChangeInitiated(cell: UITableViewCell) {
        
        guard let cell = cell as? ItemTableViewCell, index = tableView.indexPathForCell(cell)?.row else { return }
        
        let item = ItemController.sharedController.items[index]
        
        ItemController.sharedController.toggleHavePurchased(item)
        
        switch item.havePurchased.boolValue {
        case true: cell.havePurchasedButton.imageView?.image = UIImage(named: "incomplete")
        case false: cell.havePurchasedButton.imageView?.image = UIImage(named: "completed")
        }
        
    }
    

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.sharedController.items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCellWithIdentifier("itemTableCell", forIndexPath: indexPath) as? ItemTableViewCell else { return UITableViewCell() }

        let item = ItemController.sharedController.items[indexPath.row]
        
        cell.itemNameLabel.text = item.name
        
        switch item.havePurchased.boolValue {
            
        case true: cell.havePurchasedButton.imageView?.image = UIImage(named: "completed")
        case false: cell.havePurchasedButton.imageView?.image = UIImage(named: "incomplete")
            
        }

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
