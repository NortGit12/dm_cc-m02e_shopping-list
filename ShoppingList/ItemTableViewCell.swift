//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by Jeff Norton on 7/8/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    // MARK: - Stored Properties
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var havePurchasedButton: UIButton!
    
    weak var delegate: ItemPurchasedDelegate?
    
    // MARK: - General
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - Action(s)
    
    @IBAction func havePurchaseButtonTapped(sender: UIButton) {
        self.delegate?.havePurchasedStateChangeInitiated(self)
    }
    

}

protocol ItemPurchasedDelegate: class {
    
    func havePurchasedStateChangeInitiated(cell: UITableViewCell)
    
}