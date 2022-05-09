//
//  MainViewController.swift
//  ToDoDoo
//
//  Created by yxgg on 08/05/22.
//

import UIKit

class MainViewController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupTabBarController()
  }
  
  // MARK: - Helpers
  private func setupViews() {
    tabBar.tintColor = .color1
  }
  
  private func setupTabBarController() {
    let homeNavigationController = UINavigationController(rootViewController: HomeViewController())
    homeNavigationController.title = "ToDoDoo"
    homeNavigationController.tabBarItem.image = UIImage(systemName: "house.circle")
    homeNavigationController.tabBarItem.selectedImage = UIImage(systemName: "house.circle.fill")
    
    let focuseNavigationController = UINavigationController(rootViewController: FocuseViewController())
    focuseNavigationController.title = "Focus"
    focuseNavigationController.tabBarItem.image = UIImage(systemName: "clock")
    focuseNavigationController.tabBarItem.selectedImage = UIImage(systemName: "clock.fill")
    
    viewControllers = [homeNavigationController, focuseNavigationController]
  }
}
