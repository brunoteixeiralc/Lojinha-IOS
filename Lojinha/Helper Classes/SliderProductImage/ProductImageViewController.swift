//
//  ShoeImageViewController.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 15/12/2017.
//

import UIKit

class ProductImageViewController: UIViewController {

    @IBOutlet weak var imageView:UIImageView!
    
    var imageLink: String?{
        didSet{
            if let imageLink = imageLink{
                FIRImage.downloadImage(uri: imageLink, completion: { (image, error) in
                    if error == nil && image != nil{
                        self.imageView.image = image
                    }
                })
            }
        }
    }
}
