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
        didSet{
            updateUI()
        }
    }

    func updateUI(){
        if let product = product{
            
            productImage.image = nil
            if let imageLinks = product.imageLinks, let imageLink = imageLinks.first{
                FIRImage.downloadImage(uri: imageLink, completion: { (image, error) in
                    if error == nil{
                        self.productImage.image = image
                    }
                })
            }
            productNameLabel.text = product.name
            productPriceLabel.text = "R$ \(String(describing: product.price!))"
        }

    }
}

