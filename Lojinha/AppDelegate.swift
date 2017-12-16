//
//  AppDelegate.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 25/07/17.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        configureAppearence()
        
        return true
    }

    func configureAppearence(){
        
        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().isTranslucent = false
        
        UINavigationBar.appearance().tintColor = UIColor.black
        UINavigationBar.appearance().isTranslucent = false
        
    }
}
