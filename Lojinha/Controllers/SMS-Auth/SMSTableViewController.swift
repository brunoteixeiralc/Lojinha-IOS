//
//  SMSTableViewController.swift
//  Lojinha
//
//  Created by Bruno Lemgruber on 30/01/2018.
//

import UIKit
import Firebase

class SMSTableViewController: UITableViewController {
    
    @IBOutlet weak var telephoneNumber: UITextField!
    @IBOutlet weak var send: UIBarButtonItem!
    
    var codeTextFieldVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        telephoneNumber.becomeFirstResponder()
        send.isEnabled = true
    }
    
    @IBAction func didTapBack(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendSMS(){
        if let phone = telephoneNumber.text{
            showDialog(view: self, title: "Enviando SMS...")
            PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil, completion: { (verificationID, error) in
                dismissDialog(view: self)
                if let error = error{
                    showAlert(view: self, title: "Lojinha", message: error.localizedDescription)
                    return
                }
                self.performSegue(withIdentifier: "showSMSCode", sender: nil)
                print(verificationID!)
                UserDefaults.standard.set(verificationID!, forKey: "authVerificationID")
            })
        }
    }
}
