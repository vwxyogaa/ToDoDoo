//
//  AccountViewController.swift
//  ToDoDoo
//
//  Created by yxgg on 09/05/22.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {
  // MARK: - Views
  lazy var backgroundImage: UIImageView = {
    let backgroundImage = UIImageView()
    backgroundImage.image = UIImage(named: "bgImage")
    return backgroundImage
  }()
  
  lazy var userImage: UIImageView = {
    let userImage = UIImageView()
    userImage.image = UIImage(systemName: "person.crop.circle.fill")
    userImage.contentMode = .scaleAspectFill
    userImage.tintColor = .black
    userImage.layer.borderWidth = 1
    userImage.layer.borderColor = UIColor.black.cgColor
    userImage.layer.cornerRadius = 45
    userImage.layer.masksToBounds = true
    return userImage
  }()
  
  lazy var usernameLabel: UILabel = {
    let usernameLabel = UILabel()
    let user = Auth.auth().currentUser?.displayName
    usernameLabel.text = user
    usernameLabel.textAlignment = .center
    usernameLabel.textColor = .black
    usernameLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    return usernameLabel
  }()
  
  lazy var editProfileButton: UIButton = {
    let editProfileButton = UIButton(type: .system)
    editProfileButton.setTitle(" Edit Profile", for: .normal)
    editProfileButton.setTitleColor(UIColor.black, for: .normal)
    editProfileButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
    editProfileButton.tintColor = .black
    return editProfileButton
  }()
  
  lazy var logOutButton: UIButton = {
    let logOutButton = UIButton(type: .system)
    logOutButton.setTitle(" Log out", for: .normal)
    logOutButton.setTitleColor(UIColor.red, for: .normal)
    logOutButton.setImage(UIImage(systemName: "escape"), for: .normal)
    logOutButton.tintColor = .red
    return logOutButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupBackgroundImage()
    setupUserImage()
    setupUsernameLabel()
    setupEditProfileButton()
    setupLogOutButton()
  }
  
  // MARK: - Helpers
  private func setupViews() {
    view.backgroundColor = .color3
    title = "Profile"
  }
  
  private func setupBackgroundImage() {
    view.addSubview(backgroundImage)
    backgroundImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      backgroundImage.widthAnchor.constraint(equalToConstant: 150),
      backgroundImage.heightAnchor.constraint(equalToConstant: 150),
      backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
      backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    ])
  }
  
  private func setupUserImage() {
    view.addSubview(userImage)
    userImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      userImage.widthAnchor.constraint(equalToConstant: 90),
      userImage.heightAnchor.constraint(equalToConstant: 90),
      userImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
      userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
  
  private func setupUsernameLabel() {
    view.addSubview(usernameLabel)
    usernameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      usernameLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10)
    ])
  }
  
  private func setupEditProfileButton() {
    view.addSubview(editProfileButton)
    editProfileButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      editProfileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      editProfileButton.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 24)
    ])
  }
  
  private func setupLogOutButton() {
    view.addSubview(logOutButton)
    logOutButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      logOutButton.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 24)
    ])
    logOutButton.addTarget(self, action: #selector(self.setupLogOutButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func showSignInViewController() {
    let viewController = SignInViewController()
    let navigationController = UINavigationController(rootViewController: viewController)
    let window = view.window?.windowScene?.keyWindow
    window?.rootViewController = navigationController
  }
  
  // MARK: - Actions
  @objc private func setupLogOutButtonTapped(_ sender: Any) {
    let firebaseAuth = Auth.auth()
    let alert = UIAlertController(title: "Sign Out", message: "Are you sure?", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
      do {
        try firebaseAuth.signOut()
        self.showSignInViewController()
      } catch let signOutError as NSError {
        print("Error signing out: %@", signOutError)
      }
    }))
    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in }))
    present(alert, animated: true, completion: nil)
  }
}
