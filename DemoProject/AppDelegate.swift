//
//  AppDelegate.swift
//  DemoProject
//
//  Created by Hakan Üstünbaş on 19.09.2020.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let configuration = ParseClientConfiguration { (ParseMutableClientConfiguration) in
            ParseMutableClientConfiguration.applicationId = "XMNQQxZn8Kio3cdlcGamtyd7tLE3bzlIBqjQqieM"
            ParseMutableClientConfiguration.clientKey = "Cogs6AwBox4VrdmTi5J6c4jSV4ZsXwsSzA0xbi1v"
            ParseMutableClientConfiguration.server = "https://parseapi.back4app.com/"
            
        }
        Parse.initialize(with: configuration)
        
        let defaultACL = PFACL()
        defaultACL.hasPublicReadAccess = true
        defaultACL.hasPublicWriteAccess = true
        
        PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)
        
        if (PFUser.current() == nil){
             
          
        }
        
//        rememberUser()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
//    func rememberUser(){
//
//        let user: String? = UserDefaults.standard.string(forKey: "username")
//
//        if user != nil {
//
//            let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//            let tabBar = board.instantiateViewController(identifier: "tabBar") as! UITabBarController
//
//            window?.rootViewController = tabBar
//
//         }
//
//    }

}

