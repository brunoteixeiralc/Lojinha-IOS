//
//  CartTotalCell.swift
//  Nike-Retail
//
//  Created by Duc Tran on 6/18/17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit

// 16-Challenge-7: Create cart total cell

class CartTotalCell: UITableViewCell
{
    @IBOutlet weak var totalAmountLabel: UILabel!

    var shoppingCart: ShoppingCart! {
        didSet {
            totalAmountLabel.text = "R$\(shoppingCart.total!)"
        }
    }
}
