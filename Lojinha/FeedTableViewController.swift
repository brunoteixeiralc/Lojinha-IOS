//
//  FeedTableViewController.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 30/10/2017.
//

import UIKit

class FeedTableViewController: UITableViewController {

    var products: [Product]?
    
    struct StoryBoard {
        static let feedProductCell = "FeedProductCell"
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
    }

    func fetchProducts(){
        
        products = Product.fetchProducts()
        tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewController.StoryBoard.feedProductCell, for: indexPath) as! FeedProductCell
        
        if let products = products{
            let product = products[indexPath.row]
            cell.product = product
        }
        
        return cell
    }
}
