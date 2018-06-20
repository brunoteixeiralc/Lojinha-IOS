//
//  BuyButtonCell.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 13/12/2017.
//

import UIKit

protocol BuyButtonCellDelegate :class {
    func addToCart(product: Product)
}

class BuyButtonCell: UITableViewCell {

    @IBOutlet weak var buyButton: UIButton!
    
    weak var delegate: BuyButtonCellDelegate?
    
    var product: Product! {
        didSet{
            buyButton.setTitle("Comprar R$ \(product.price!)", for: [])
        }
    }
    
    @IBAction func buyButtonDidTap(){
        delegate?.addToCart(product: product)
    }
}
