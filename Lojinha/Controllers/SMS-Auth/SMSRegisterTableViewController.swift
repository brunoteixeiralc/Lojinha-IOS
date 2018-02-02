//
//  SMSRegisterTableViewController.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 01/02/2018.
//

import UIKit

class SMSRegisterTableViewController: UITableViewController {
    
    var code:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapBack(){
        dismiss(animated: true, completion: nil)
    }
}
