//
//  WelcomeViewController.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 03/01/2018.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user != nil{
                self.dismiss(animated: false, completion: nil)
            }else{
                
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
