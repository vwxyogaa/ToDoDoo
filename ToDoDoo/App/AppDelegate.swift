//
//  AppDelegate.swift
//  ToDoDoo
//
//  Created by yxgg on 06/05/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    let window = UIWindow()
    if Auth.auth().currentUser == nil {
      window.rootViewController = FtuxViewController()
    } else {
      window.rootViewController = MainViewController()
    }
    window.makeKeyAndVisible()
    self.window = window
    return true
  }
  
  // MARK: - UISceneSession Lifecycle
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
}

