//
//  CheckoutTableViewController.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 20/12/2017.
//

import UIKit

class CheckoutTableViewController: UITableViewController {

    struct Storyboard {
        static let billingTitleCell = "billingTitleCell"
        static let billingInfoCell = "billingInfoCell"
        static let totalCell = "totalCell"
        static let submitButtonCell = "submitButtonCell"
        static let cartDetailCell = "cartDetailCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension CheckoutTableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.billingTitleCell, for: indexPath)
            return cell
            
        }else if indexPath.row == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.billingInfoCell, for: indexPath) as! CreditCardInformationCell
            return cell
            
        }else if indexPath.row == 2{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.cartDetailCell, for: indexPath)
            return cell
            
        }else if indexPath.row == 3{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.totalCell, for: indexPath)
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.submitButtonCell, for: indexPath)
            return cell
        }
    }
    
}
