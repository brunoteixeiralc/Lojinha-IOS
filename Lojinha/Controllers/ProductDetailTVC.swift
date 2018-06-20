//
//  ProductDetailTVC.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 13/12/2017.
//

import UIKit

class ProductDetailTVC: UITableViewController {
    
    var product:Product!
    
    @IBOutlet weak var productImagesHeaderView:ProductImagesHeaderView!
    
    struct Storyboard {
        static let productDetailCell = "ProductDetailCell"
        static let buyButtomCell = "BuyButtonCell"
        static let showProductDetailCell = "ShowProductDetailCell"
        static let showImagesPageViewController = "ShowImagesPageViewController"
        static let suggestionCell = "SuggestionTableViewCell"
        static let suggestionCollectionView = "SuggestionCollectionViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = product.name
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showImagesPageViewController{
            if let imagesPageVC = segue.destination as? ProductImagesPageViewController{
                imagesPageVC.product = product
                imagesPageVC.pageViewControllerDelegate = productImagesHeaderView
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3{
            return tableView.bounds.width + 68
        }
        
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.productDetailCell, for: indexPath) as! ProductDetailCell
            cell.product = product
            cell.selectionStyle = .none
            return cell
            
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.buyButtomCell, for: indexPath) as! BuyButtonCell
            cell.product = product
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
            
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.showProductDetailCell, for: indexPath) as! ProductDetailCell
            cell.selectionStyle = .none
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.suggestionCell, for: indexPath) as! SuggestionTableViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 3{
            if let cell = cell as? SuggestionTableViewCell{
                cell.collectionView.dataSource = self
                cell.collectionView.delegate = self
                cell.collectionView.reloadData()
                cell.collectionView.isScrollEnabled = false
            }
        }
    }
}

extension ProductDetailTVC: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.suggestionCollectionView, for: indexPath) as! SuggestionCollectionViewCell
        
        let products = Product.fetchProducts()
        cell.image = products[indexPath.item].image?.first
        
        return cell
    }
}

extension ProductDetailTVC: UICollectionViewDelegate{
}

extension ProductDetailTVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 5.0
            layout.minimumLineSpacing = 2.0
            let itemWidth = (collectionView.bounds.width - 5.0)/2.0
            return CGSize(width: itemWidth, height: itemWidth)
        }
        
        return CGSize.zero
    }
}

extension ProductDetailTVC: BuyButtonCellDelegate{
    func addToCart(product: Product) {
        ShoppingCart.add(product: product)
    }
}
