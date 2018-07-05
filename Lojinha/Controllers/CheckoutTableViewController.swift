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
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expirationDateTextField: UITextField!
    @IBOutlet weak var securityTextField: UITextField!
    
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var submitOrderButton: UIButton!
    
    var shoppingCart:ShoppingCart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        updateUI()
    }
    
    func updateUI(){
        if shoppingCart != nil{
            if let subtotal = shoppingCart.subtotal, let shipping = shoppingCart.shipping, let tax = shoppingCart.tax, let total = shoppingCart.total{
                subTotalLabel.text = "R$\(subtotal)"
                if shipping == 0 {
                    shippingCostLabel.text = "GRÁTIS"
                }else{
                    shippingCostLabel.text = "R$\(shipping)"
                }
                taxLabel.text = "R$\(tax)"
                totalLabel.text = "R$\(total)"
            }
        }
    }
}
