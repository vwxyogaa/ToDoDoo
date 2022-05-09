//
//  SignUpViewController.swift
//  ToDoDoo
//
//  Created by yxgg on 06/05/22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
  private var isNameValid = false
  private var isEmailValid = false
  private var isPasswordValid = false
  
  // MARK: - Views
  lazy var backgroundImage: UIImageView = {
    let backgroundImage = UIImageView()
    backgroundImage.image = UIImage(named: "bgImage")
    backgroundImage.contentMode = .scaleAspectFill
    return backgroundImage
  }()
  
  lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.text = "Welcome Onboard!"
    titleLabel.textColor = .black
    titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    titleLabel.textAlignment = .center
    return titleLabel
  }()
  
  lazy var subtitleLabel: UILabel = {
    let subtitleLabel = UILabel()
    subtitleLabel.text = "Let’s help you to meet your Task!"
    subtitleLabel.textColor = .black
    subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    subtitleLabel.textAlignment = .center
    return subtitleLabel
  }()
  
  lazy var nameTextField: CustomTextField = {
    let nameTextField = CustomTextField(inputType: .undefined)
    nameTextField.placeholder = "Name"
    nameTextField.backgroundColor = .white
    nameTextField.layer.cornerRadius = 10
    nameTextField.layer.masksToBounds = true
    return nameTextField
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
  
  lazy var registerButton: PrimaryButton = {
    let registerButton = PrimaryButton()
    registerButton.setTitle("Register", for: .normal)
    return registerButton
  }()
  
  lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.spacing = 4
    return stackView
  }()
  
  lazy var signInLabel: UILabel = {
    let signInLabel = UILabel()
    signInLabel.text = "Already have Account?"
    signInLabel.textColor = .black
    signInLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    return signInLabel
  }()
  
  lazy var signInButton: SecondaryButton = {
    let signInButton = SecondaryButton()
    signInButton.setTitle("Sign In", for: .normal)
    return signInButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupBackgroundImage()
    setupTitleLabel()
    setupSubtitleLabel()
    setupNameTextField()
    setupEmailTextField()
    setupPasswordTextField()
    let textFields: [UITextField] = [nameTextField, emailTextField, passwordTextField]
    for textField in textFields {
      setupTextFields(for: textField)
    }
    setupRegisterButton()
    setupStackView()
  }
  
  // MARK: - Helpers
  private func setupTextFields(for textField: UITextField) {
    let exclamationMarkButton = UIButton(type: .custom)
    exclamationMarkButton.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
    exclamationMarkButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    exclamationMarkButton.frame = CGRect(
      x: CGFloat(nameTextField.frame.size.width - 25),
      y: CGFloat(5),
      width: CGFloat(25),
      height: CGFloat(25)
    )
    
    switch textField {
    case nameTextField:
      exclamationMarkButton.addTarget(self, action: #selector(self.showNameExistAlert(_:)), for: .touchUpInside)
      textField.addTarget(self, action: #selector(nameTextFieldDidChange(_:)), for: .editingChanged)
    case emailTextField:
      exclamationMarkButton.addTarget(self, action: #selector(self.showEmailExistAlert(_:)), for: .touchUpInside)
      textField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
    case passwordTextField:
      exclamationMarkButton.addTarget(self, action: #selector(self.showPasswordExistAlert(_:)), for: .touchUpInside)
      textField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
    default:
      print("TextField not found")
    }
    textField.rightView = exclamationMarkButton
  }
  
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
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
    ])
  }
  
  private func setupSubtitleLabel() {
    view.addSubview(subtitleLabel)
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
      subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
    ])
  }
  
  private func setupNameTextField() {
    view.addSubview(nameTextField)
    nameTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
      nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      nameTextField.heightAnchor.constraint(equalToConstant: 46)
    ])
  }
  
  private func setupEmailTextField() {
    view.addSubview(emailTextField)
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
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
  
  private func setupRegisterButton() {
    view.addSubview(registerButton)
    registerButton.isEnabled = false
    registerButton.backgroundColor = .systemGray
    registerButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 60),
      registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      registerButton.heightAnchor.constraint(equalToConstant: 56)
    ])
    registerButton.addTarget(self, action: #selector(self.registerButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func setupStackView() {
    view.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 24),
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    stackView.addArrangedSubview(signInLabel)
    stackView.addArrangedSubview(signInButton)
    
    signInButton.addTarget(self, action: #selector(self.signInButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func isValidEmail(from email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
  }
  
  private func validateButton() {
    if isNameValid && isEmailValid && isPasswordValid {
      registerButton.isEnabled = true
      registerButton.backgroundColor = .color1
    } else {
      registerButton.isEnabled = false
      registerButton.backgroundColor = UIColor.systemGray
    }
  }
  
  // MARK: - Actions
  @objc private func signInButtonTapped(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func nameTextFieldDidChange(_ textField: UITextField) {
    if let input = textField.text {
      if input.isEmpty {
        isNameValid = false
        textField.rightViewMode = .always
      } else {
        isNameValid = true
        textField.rightViewMode = .never
      }
      validateButton()
    }
  }
  
  @objc func emailTextFieldDidChange(_ textField: UITextField) {
    if let input = textField.text {
      if isValidEmail(from: input) {
        isEmailValid = true
        textField.rightViewMode = .never
      } else {
        isEmailValid = false
        textField.rightViewMode = .always
      }
      validateButton()
    }
  }
  
  @objc func passwordTextFieldDidChange(_ textField: UITextField) {
    if let input = textField.text {
      if input.count < 6 {
        isPasswordValid = false
        textField.rightViewMode = .always
      } else {
        isPasswordValid = true
        textField.rightViewMode = .never
      }
      validateButton()
    }
  }
  
  @objc func showNameExistAlert(_ sender: Any) {
    let alertController = UIAlertController(
      title: "Your name is invalid.",
      message: "Please double check your name, for example Gilang Ramadhan.",
      preferredStyle: .alert
    )
    alertController.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(alertController, animated: true, completion: nil)
  }
  
  @objc func showEmailExistAlert(_ sender: Any) {
    let alertController = UIAlertController(
      title: "Your email is invalid.",
      message: "Please double check your email format, for example like gilang@dicoding.com.",
      preferredStyle: .alert
    )
    alertController.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(alertController, animated: true, completion: nil)
  }
  
  @objc func showPasswordExistAlert(_ sender: Any) {
    let alertController = UIAlertController(
      title: "Your password is invalid.",
      message: "Please double check the character length of your password.",
      preferredStyle: .alert
    )
    alertController.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(alertController, animated: true, completion: nil)
  }
}

// MARK: - SignUp with Firebase
extension SignUpViewController {
  @objc private func registerButtonTapped(_ sender: Any) {
    signUpWithFirebase()
  }
  
  func signUpWithFirebase() {
    guard let name = nameTextField.text else { return }
    guard let email = emailTextField.text else { return }
    guard let password = passwordTextField.text else { return }
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
      if let error = error as? NSError {
        switch AuthErrorCode(rawValue: error.code) {
        case .emailAlreadyInUse:
          let alert = UIAlertController(title: "Oops", message: "The email address is already in use by another account", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
          self.present(alert, animated: true, completion: nil)
        default:
          print("Error: \(error.localizedDescription)")
        }
      } else {
        print("User sign up successfully")
        let request = authResult?.user.createProfileChangeRequest()
        request?.displayName = name
        request?.commitChanges(completion: { error in
          if let error = error {
            print(error.localizedDescription)
          }
          self.navigationController?.popToRootViewController(animated: true)
        })
      }
    }
  }
}
