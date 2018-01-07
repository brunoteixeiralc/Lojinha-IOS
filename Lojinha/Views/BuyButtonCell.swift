//
//  BuyButtonCell.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 13/12/2017.
//

import UIKit

class BuyButtonCell: UITableViewCell {

    @IBOutlet weak var buyButton: UIButton!
    
    var product: Product! {
        didSet{
            buyButton.setTitle("Comprar R$ \(product.price!)", for: [])
        }
    }
}
