//
//  ShoppingCartItemCell.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 20/12/2017.
//

import UIKit

class ShoppingCartItemCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    var product: Product!{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        productImageView.image = nil
        if let imageLink = product.featuredImageLink {
            FIRImage.downloadImage(uri: imageLink, completion: { (image, error) in
                self.productImageView.image = image
            })
        }
        
        productNameLabel.text = product.name
        priceLabel.text = "R$\(product.price!)"
    }
}
