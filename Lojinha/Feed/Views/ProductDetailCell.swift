//
//  ProductDetailCell.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 13/12/2017.
//

import UIKit

class ProductDetailCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    var product: Product?{
        didSet{
            productNameLabel.text = product?.name
            productDescriptionLabel.text = product?.description
        }
    }

}
