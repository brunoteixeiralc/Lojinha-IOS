//
//  AppDelegate.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 25/07/17.
//
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate{

    var window: UIWindow?
    
    func configureAppearence(){
        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().isTranslucent = false
        
        UINavigationBar.appearance().tintColor = UIColor.black
        UINavigationBar.appearance().isTranslucent = false
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        FBSDKApplicationDelegate.sharedInstance().application(application,
                                                              didFinishLaunchingWithOptions:launchOptions)
        
        let key = Bundle.main.object(forInfoDictionaryKey: "consumerKey"),
        secret = Bundle.main.object(forInfoDictionaryKey: "consumerSecret")
        if let key = key as? String, let secret = secret as? String, !key.isEmpty && !secret.isEmpty {
            TWTRTwitter.sharedInstance().start(withConsumerKey: key, consumerSecret: secret)
        }
        configureAppearence()
        
        return true
    }
    
    //MARK: SMS Auth
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Auth.auth().setAPNSToken(deviceToken, type: AuthAPNSTokenType.sandbox)
    }
    
    func application(_ application: UIApplication,didReceiveRemoteNotification notification: [AnyHashable : Any],fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(notification) {
            completionHandler(UIBackgroundFetchResult.noData)
            return
        }
    }
    
    // MARK: Google +
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
          let googleAuthentication =  GIDSignIn.sharedInstance().handle(url,sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,annotation: [:])
        
        let facebookAuthentication = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
         let twitterAuthentication = TWTRTwitter.sharedInstance().application(application, open: url, options: options)
        
        return googleAuthentication || facebookAuthentication || twitterAuthentication
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,sourceApplication: sourceApplication,annotation: annotation)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        guard let controller = GIDSignIn.sharedInstance().uiDelegate as? RegisterTypeViewController else { return }
        
        if let error = error {
            showAlert(view: (self.window?.rootViewController)!, title: "Lojinha", message: error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
        controller.firebaseLogin(credential)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
    }
}

