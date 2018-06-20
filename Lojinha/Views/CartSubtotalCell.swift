//
//  CartSubtotalCell.swift
//  Nike-Retail
//
//  Created by Duc Tran on 6/18/17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit

// 16-Challenge-6: Create cart subtotal cell

class CartSubtotalCell: UITableViewCell {

    var shoppingCart: ShoppingCart! {
        didSet {
            subtotalLabel.text = "R$\(shoppingCart.subtotal!)"
            shippingCostLabel.text = shoppingCart.shipping! == 0 ? "FREE" : "R$\(shoppingCart.shipping!)"
            taxAmountLabel.text = "R$\(shoppingCart.tax!)"
        }
    }
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var taxAmountLabel: UILabel!
}
