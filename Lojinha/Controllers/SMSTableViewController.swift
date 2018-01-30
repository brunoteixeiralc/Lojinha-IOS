//
//  SMSTableViewController.swift
//  Lojinha
//
//  Created by Bruno Lemgruber on 30/01/2018.
//

import UIKit

class SMSTableViewController: UITableViewController {
    
    @IBOutlet weak var smsCodeCell: UITableViewCell!
    @IBOutlet weak var smsCode: UITextField!
    @IBOutlet weak var telephoneNumber: UITextField!
    @IBOutlet weak var send: UIBarButtonItem!
    
    var codeTextFieldVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapBack(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendSMS(){
        
    }
}
