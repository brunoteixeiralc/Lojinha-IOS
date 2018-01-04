//
//  LoginTableViewController.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 28/12/2017.
//

import UIKit
import Firebase

class LoginTableViewController: UITableViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailUserTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        emailUserTextField.delegate = self
    }
    
    @IBAction func createNewAccountDidTap() {
        
        if(emailUserTextField.text != "" && (passwordTextField.text?.count)! > 6){
            let email = emailUserTextField.text
            let password = passwordTextField.text
            
            Auth.auth().signIn(withEmail: email!, password: password!, completion: { (firUser, error) in
                if let error = error{
                    fatalFirebaseError(error)
                }else{
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func didTapBack(){
        dismiss(animated: true, completion: nil)
    }
}

extension LoginTableViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailUserTextField{
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField{
            passwordTextField.resignFirstResponder()
            createNewAccountDidTap()
        }
        
        return true
    }
    
}
