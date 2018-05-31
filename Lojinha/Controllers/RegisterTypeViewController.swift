//
//  RegisterTypeViewController.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 28/12/2017.
//

import UIKit
import GoogleSignIn
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import TwitterKit

class RegisterTypeViewController: UIViewController,GIDSignInUIDelegate {
    
    @IBOutlet weak var signInButtonGooglePlus:UIButton!
    
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
    
    @IBAction func signInFacebook(){
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email"], from: self, handler: { (result, error) in
            if let error = error {
                showAlert(view: self, title: "Lojinha", message: error.localizedDescription)
            } else if result!.isCancelled {
                print("FBLogin cancelled")
            } else {
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseLogin(credential)
            }
        })
    }
    
    @IBAction func signInTwitter(){
        TWTRTwitter.sharedInstance().logIn() { (session, error) in
            if let session = session {
                let credential = TwitterAuthProvider.credential(withToken: session.authToken, secret: session.authTokenSecret)
                self.firebaseLogin(credential)
            } else {
                showAlert(view: self, title: "Lojinha", message: (error?.localizedDescription)!)
            }
        }
    }
}

extension RegisterTypeViewController{
    
    func firebaseLogin(_ credential: AuthCredential){
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                showAlert(view: self, title: "Lojinha", message: error.localizedDescription)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}
