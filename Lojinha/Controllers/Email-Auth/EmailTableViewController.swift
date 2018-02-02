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
            
            self.showDialog()
            
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
                            self.dismissDialog()
                             self.showAlert(title: "Opps...", message: "Houve um erro para se cadastrar. Por favor tente novamente.")
                        }else{
                            firuser.sendEmailVerification(completion: { (error) in
                                if error == nil{
                                    self.dismissDialog()
                                    self.showAlert(title: "Lojinha", message: "Parabéns! Você foi cadastrado com sucesso.\n Verifique seu email para confirmar seu login.")
                                }
                            })
                        }
                    })
                }
            })
        }else{
             self.showAlert(title: "Opps...", message: "Houve um erro para se cadastrar. Por favor tente novamente.")
        }
    }
    
    @IBAction func changeProfileImageDidTap(_ sender: Any){
        
        imagePickerHelper = ImagePickerHelper(viewController: self, completion: { (image) in
            self.profileImageView.image = image
            self.profileImage = image
        })
    }
}

extension EmailTableViewController{
    
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
    
    func showDialog(){
        let alert = UIAlertController(title: nil, message: "Cadastrando...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func dismissDialog(){
        dismiss(animated: false, completion: nil)
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
