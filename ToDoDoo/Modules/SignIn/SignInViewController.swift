//
//  SignInViewController.swift
//  ToDoDoo
//
//  Created by yxgg on 06/05/22.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
  // MARK: - Views
  lazy var backgroundImage: UIImageView = {
    let backgroundImage = UIImageView()
    backgroundImage.image = UIImage(named: "bgImage")
    backgroundImage.contentMode = .scaleAspectFill
    return backgroundImage
  }()
  
  lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.text = "Hai, have a nice day!"
    titleLabel.textAlignment = .center
    titleLabel.textColor = .black
    titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    return titleLabel
  }()
  
  lazy var thumbImage: UIImageView = {
    let thumbImage = UIImageView()
    thumbImage.image = UIImage(named: "thumbImage2")
    thumbImage.contentMode = .scaleAspectFill
    return thumbImage
  }()
  
  lazy var emailTextField: CustomTextField = {
    let emailTextField = CustomTextField(inputType: .email)
    emailTextField.placeholder = "Email"
    emailTextField.backgroundColor = .white
    emailTextField.layer.cornerRadius = 10
    emailTextField.layer.masksToBounds = true
    return emailTextField
  }()
  
  lazy var passwordTextField: CustomTextField = {
    let passwordTextField = CustomTextField(inputType: .password)
    passwordTextField.placeholder = "Password"
    passwordTextField.backgroundColor = .white
    passwordTextField.layer.cornerRadius = 10
    passwordTextField.layer.masksToBounds = true
    return passwordTextField
  }()
  
  lazy var forgotPasswordButton: SecondaryButton = {
    let forgotPasswordButton = SecondaryButton()
    forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
    return forgotPasswordButton
  }()
  
  lazy var signInButton: PrimaryButton = {
    let signInButton = PrimaryButton()
    signInButton.setTitle("Sign In", for: .normal)
    return signInButton
  }()
  
  lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.spacing = 4
    return stackView
  }()
  
  lazy var signUpLabel: UILabel = {
    let signUpLabel = UILabel()
    signUpLabel.text = "Dont’t have Account?"
    signUpLabel.textColor = .black
    signUpLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    return signUpLabel
  }()
  
  lazy var signUpButton: SecondaryButton = {
    let signUpButton = SecondaryButton()
    signUpButton.setTitle("Sign Up", for: .normal)
    return signUpButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupBackgroundImage()
    setupTitleLabel()
    setupThumbImage()
    setupEmailTextField()
    setupPasswordTextField()
    setupForgotPasswordButton()
    setupSignInButton()
    setupStackView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  // MARK: - Helpers
  private func setupViews() {
    view.backgroundColor = .color3
  }
  
  private func setupBackgroundImage() {
    view.addSubview(backgroundImage)
    backgroundImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      backgroundImage.heightAnchor.constraint(equalToConstant: 150),
      backgroundImage.widthAnchor.constraint(equalToConstant: 150),
      backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backgroundImage.topAnchor.constraint(equalTo: view.topAnchor)
    ])
  }
  
  private func setupTitleLabel() {
    view.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
    ])
  }
  
  private func setupThumbImage() {
    view.addSubview(thumbImage)
    thumbImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      thumbImage.widthAnchor.constraint(equalToConstant: 170),
      thumbImage.heightAnchor.constraint(equalToConstant: 170),
      thumbImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      thumbImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60)
    ])
  }
  
  private func setupEmailTextField() {
    view.addSubview(emailTextField)
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      emailTextField.topAnchor.constraint(equalTo: thumbImage.bottomAnchor, constant: 40),
      emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      emailTextField.heightAnchor.constraint(equalToConstant: 46)
    ])
  }
  
  private func setupPasswordTextField() {
    view.addSubview(passwordTextField)
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
      passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      passwordTextField.heightAnchor.constraint(equalToConstant: 46)
    ])
  }
  
  private func setupForgotPasswordButton() {
    view.addSubview(forgotPasswordButton)
    forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
      forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
  
  private func setupSignInButton() {
    view.addSubview(signInButton)
    signInButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
      signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      signInButton.heightAnchor.constraint(equalToConstant: 56)
    ])
    signInButton.addTarget(self, action: #selector(self.signInButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func setupStackView() {
    view.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 24),
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
    ])
    stackView.addArrangedSubview(signUpLabel)
    stackView.addArrangedSubview(signUpButton)
    signUpButton.addTarget(self, action: #selector(self.signUpButtonTapped(_:)), for: .touchUpInside)
  }
  
  func isValid() -> Bool {
    guard let email = emailTextField.text, email.isValidEmail else {
      let alert = UIAlertController(title: "Oops!", message: "Invalid email", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
      self.present(alert, animated: true)
      return false
    }
    
    guard let password = passwordTextField.text else {
      let alert = UIAlertController(title: "Oops!", message: "Invalid password", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
      self.present(alert, animated: true)
      return false
    }
    return true
  }
  
  // MARK: - Actions
  @objc private func signUpButtonTapped(_ sender: Any) {
    let viewController = SignUpViewController()
    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: - SignIn with Firebase
extension SignInViewController {
  @objc private func signInButtonTapped(_ sender: Any) {
    if isValid() {
      signInWithFirebase()
    }
  }
  
  func signInWithFirebase() {
    guard let email = emailTextField.text else { return }
    guard let password = passwordTextField.text else { return }
    Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
//      guard let strongSelf = self else { return }
      if let error = error as? NSError {
        switch AuthErrorCode(rawValue: error.code) {
        case .wrongPassword:
          let alert = UIAlertController(title: "Oops", message: "Invalid password", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
          self?.present(alert, animated: true)
        default:
          print("Error: \(error.localizedDescription)")
          let alert = UIAlertController(title: "Oops", message: "This email may have been unverified or invalid password", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
          self?.present(alert, animated: true)
        }
      } else {
        print("User signs in successfully")
        let viewController = MainViewController()
        let window = self?.view.window?.windowScene?.keyWindow
        window?.rootViewController = viewController
      }
    }
  }
}
