//
//  SuggestionCollectionViewCell.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 18/12/2017.
//

import UIKit

class SuggestionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage!{
        didSet{
            imageView.image = image
            setNeedsLayout()
        }
    }
}
