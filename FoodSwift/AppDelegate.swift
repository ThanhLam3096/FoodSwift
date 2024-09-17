//
//  AppDelegate.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 23/4/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let customTitleFont = UIFont.hiraginoSansW6(ofSize: 16)
//        let attributes: [NSAttributedString.Key: Any] = [
//            .font: customTitleFont as Any,
//            .foregroundColor: UIColor.black // Bạn có thể tùy chỉnh màu sắc nếu muốn
//        ]
//        UINavigationBar.appearance().titleTextAttributes = attributes
//        UINavigationBar.appearance().largeTitleTextAttributes = attributes
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
    
    
}

