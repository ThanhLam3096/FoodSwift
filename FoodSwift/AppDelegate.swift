//
//  AppDelegate.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 23/4/24.
//

import UIKit
import SVProgressHUD
import Firebase
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore

typealias HUD = SVProgressHUD
typealias firebaseAUTH = Auth
let db = Firestore.firestore()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        HUD.setDefaultStyle(.light)
        HUD.setDefaultMaskType(.custom)
        HUD.setBackgroundLayerColor(.gray.withAlphaComponent(0.5))
        HUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: 0))
        FirebaseApp.configure()
        Thread.sleep(forTimeInterval: 3)
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
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
}

