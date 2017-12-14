//
//  ProductDetailTVC.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 13/12/2017.
//

import UIKit

class ProductDetailTVC: UITableViewController {
    
    var product:Product!
    
    struct Storyboard {
        static let productDetailCell = "ProductDetailCell"
        static let buyButtomCell = "BuyButtonCell"
        static let showProductDetailCell = "ShowProductDetailCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = product.name
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
            return cell
            
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.showProductDetailCell, for: indexPath) as! ProductDetailCell
            cell.selectionStyle = .none
            return cell
            
        }else{
           return UITableViewCell()
        }
    }
}
