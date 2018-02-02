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
            PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil, completion: { (verificationID, error) in
                if let error = error{
                    print(error)
                    return
                }
                self.performSegue(withIdentifier: "showSMSCode", sender: nil)
                print(verificationID!)
                UserDefaults.standard.set(verificationID!, forKey: "authVerificationID")
            })
        }
    }
}
