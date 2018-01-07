//
//  FeedProductCell.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 30/10/2017.
//

import UIKit

class FeedProductCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    var product: Product?{
        didSet{
            updateUI()
        }
    }

    func updateUI(){
        if let product = product{
            productImage.image = product.image?.first
            productNameLabel.text = product.name
            productPriceLabel.text = "\(String(describing: product.price!))"
        }

    }
}

