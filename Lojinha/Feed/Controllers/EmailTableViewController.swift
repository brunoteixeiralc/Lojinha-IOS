//
//  EmailTableViewController.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 28/12/2017.
//

import UIKit

class EmailTableViewController: UITableViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    var imagePickerHelper:ImagePickerHelper!
    var profileImage:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //round images
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2.0
        profileImageView.layer.masksToBounds = true
        
        emailTextField.delegate = self
        fullNameTextField.delegate = self
        userNameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func didTapBack(){
      dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeProfileImageDidTap(_ sender: Any){
        
        imagePickerHelper = ImagePickerHelper(viewController: self, completion: { (image) in
            self.profileImageView.image = image
            self.profileImage = image
        })
    }
}

extension EmailTableViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField{
            fullNameTextField.becomeFirstResponder()
        }else if textField == fullNameTextField{
            userNameTextField.becomeFirstResponder()
        }else if textField == userNameTextField{
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField{
            passwordTextField.resignFirstResponder()
            //createNewAccountDidTap()
        }
        
        return true
    }
    
}
