//
//  RegisterTypeViewController.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 28/12/2017.
//

import UIKit
import GoogleSignIn
import Firebase

class RegisterTypeViewController: UIViewController,GIDSignInUIDelegate {
    
    @IBOutlet weak var signInButtonGooglePlus:UIButton!
    
    var credentialGooglePlus: AuthCredential!{
        didSet{
            Auth.auth().signIn(with: credentialGooglePlus) { (user, error) in
                if let error = error {
                    print(error)
                    return
                }
                print(user!.displayName ?? "")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    @IBAction func didTapBack(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInGooglePlus(){
        GIDSignIn.sharedInstance().signIn()
    }
}
