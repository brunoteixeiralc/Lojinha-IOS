//
//  SMSCodeTableViewController.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 01/02/2018.
//

import UIKit

class SMSCodeTableViewController: UITableViewController {
    
    @IBOutlet weak var smsCode: UITextField!
    @IBOutlet weak var send: UIBarButtonItem!
    @IBOutlet weak var btnReSend: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        smsCode.delegate = self
        smsCode.becomeFirstResponder()
        send.isEnabled = false
    }
   
    @IBAction func didTapBack(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func register(){
        self.performSegue(withIdentifier: "showSMSRegister", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSMSRegister"{
            let smsResgister = segue.destination as! SMSRegisterTableViewController
            smsResgister.code = smsCode.text!
        }
    }
}

extension SMSCodeTableViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField.text?.count == 5){
            send.isEnabled = true
        }else{
            send.isEnabled = false
        }
        return true
    }
    
}
