//
//  EmailTableViewController.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 28/12/2017.
//

import UIKit
import Firebase

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
    
    @IBAction func didTapCreateNewUser(){
        
        if emailTextField.text != ""
            && (passwordTextField.text?.count)! > 6
            && (userNameTextField.text?.count)! > 6
            && fullNameTextField.text != ""
            && profileImage != nil{
            
            showDialog(view: self, title: "Cadastrando...")
            
            let email = emailTextField.text!
            let password = passwordTextField.text!
            let username = userNameTextField.text!
            let fullname = fullNameTextField.text!
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { (firuser, error) in
                if(error != nil){
                    
                }else if let firuser = firuser{
                    
                    let newUser = User(uid: firuser.uid, email:email, userName: username, fullName: fullname, profileImage: self.profileImage)
                    newUser.save(completion: { (error) in
                        if error != nil{
                             dismissDialog(view: self)
                             showAlert(view:self, title: "Opps...", message: "Houve um erro para se cadastrar. Por favor tente novamente.")
                        }else{
                            firuser.sendEmailVerification(completion: { (error) in
                                if error == nil{
                                    dismissDialog(view: self)
                                    showAlert(view:self,title: "Lojinha", message: "Parabéns! Você foi cadastrado com sucesso.\n Verifique seu email para confirmar seu login.")
                                }
                            })
                        }
                    })
                }
            })
        }else{
             showAlert(view: self, title: "Opps...", message: "Houve um erro para se cadastrar. Por favor tente novamente.")
        }
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
            didTapCreateNewUser()
        }
        
        return true
    }
}
