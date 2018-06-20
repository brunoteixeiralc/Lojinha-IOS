//
//  ShoppingBagTableViewController.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 20/12/2017.
//

import UIKit

class ShoppingBagTableViewController: UITableViewController {

    var products: [Product]?
    var shoppingCart = ShoppingCart()
    
    struct Storyboard {
        static let numberOfItemsCell = "numberOfItemsCell"
        static let itemCell = "itemCell"
        static let cartDetailCell = "cartDetailCell"
        static let totalCell = "totalCell"
        static let checkoutButtonCell = "checkoutButtonCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchProducts()
    }
    
    func fetchProducts()
    {
        self.products?.removeAll()
        shoppingCart.fetch { [weak self] () in
            self?.products = self?.shoppingCart.products
            self?.tableView.reloadData()
        }
    }
}

extension ShoppingBagTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let products = products{
            return products.count + 4
        }else{
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let product = products else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.numberOfItemsCell, for: indexPath) as! NumberOfItemsCell
            cell.numberOfItemsLabel.text = "0 Item"
            return cell
        }
        
        if indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.numberOfItemsCell, for: indexPath) as! NumberOfItemsCell
            cell.numberOfItemsLabel.text = (products?.count == 1) ? "\(products?.count ?? 0) Item" : "\(products?.count ?? 0) Itens"
            return cell
            
        }else if indexPath.row == product.count + 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.cartDetailCell, for: indexPath) as! CartSubtotalCell
            cell.shoppingCart = shoppingCart
            return cell
            
        }else if indexPath.row == product.count + 2{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.totalCell, for: indexPath) as! CartTotalCell
            cell.shoppingCart = shoppingCart
            return cell
            
        }else if indexPath.row == product.count + 3{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.checkoutButtonCell, for: indexPath)
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.itemCell, for: indexPath) as! ShoppingCartItemCell
            cell.product = products![indexPath.row - 1]
            return cell
        }
    }
    
}
