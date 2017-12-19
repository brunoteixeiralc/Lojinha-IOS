//
//  FeedTableViewController.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 30/10/2017.
//

import UIKit

class FeedTableViewController: UITableViewController {

    var products: [Product]?
    private var selectedProduct : Product?
    
    struct StoryBoard {
        static let feedProductCell = "FeedProductCell"
        static let showProductDetail = "ShowProductDetail"
    }
    
    var searchBar: UISearchBar!
    var searchText:String?{
        didSet{
            fetchProducts()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Lista de produtos"
        fetchProducts()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    func fetchProducts(){
        products = Product.fetchProducts()
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoard.showProductDetail{
            if let productDetailVC = segue.destination as? ProductDetailTVC{
                productDetailVC.product = selectedProduct
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let products = products{
            return products.count
        }else{
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 451
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewController.StoryBoard.feedProductCell, for: indexPath) as! FeedProductCell
        
        if let products = products{
            let product = products[indexPath.row]
            cell.product = product
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = products?[indexPath.row]
        performSegue(withIdentifier: StoryBoard.showProductDetail, sender: nil)
    
    }
}
