//
//  SceneDelegate.swift
//  ToDoDoo
//
//  Created by yxgg on 06/05/22.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    if Auth.auth().currentUser == nil {
      window.rootViewController = FtuxViewController()
    } else {
      window.rootViewController = MainViewController()
    }
    window.makeKeyAndVisible()
    self.window = window
  }
}
