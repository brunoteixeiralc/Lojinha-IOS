//
//  AppDelegate.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 25/07/17.
//
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        configureAppearence()
        
        listenForFatalFirebaseNotification()
        
        return true
    }
    
    func listenForFatalFirebaseNotification(){
        NotificationCenter.default.addObserver(forName: FirebaseFailedNotification, object: nil, queue: OperationQueue.main) { (notification) in
            let message = """
Ocorreu um erro no aplicativo e não pode ser continuado.

Pressione OK para fechar o app. Desculpe pelo incoveniente.
"""
            let alert = UIAlertController(title: "Erro Interno", message: message, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            
            //TODO melhorar
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Circles") as UIViewController
            self.window?.rootViewController = initialViewControlleripad
           let tabController = self.window!.rootViewController!
           tabController.present(alert, animated: true, completion: nil)
        }
    }

    func configureAppearence(){
        
        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().isTranslucent = false
        
        UINavigationBar.appearance().tintColor = UIColor.black
        UINavigationBar.appearance().isTranslucent = false
        
    }
}

