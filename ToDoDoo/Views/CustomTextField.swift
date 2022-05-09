//
//  CustomTextField.swift
//  ToDoDoo
//
//  Created by yxgg on 06/05/22.
//

import UIKit

class CustomTextField: UITextField {
  enum InputType {
    case email
    case password
    case undefined
  }
  
  private weak var secureButton: UIButton?
  private var inputType: InputType = .undefined
  
  convenience init(inputType: InputType) {
    self.init(frame: .zero)
    self.inputType = inputType
    setup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  override var isSelected: Bool {
    didSet {
      update()
    }
  }
  
  override var text: String? {
    didSet {
      update()
    }
  }
  
  override var placeholder: String? {
    didSet {
      update()
    }
  }
  
  override var isSecureTextEntry: Bool {
    didSet {
      update()
    }
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    let isPassword = inputType == .password
    return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: isPassword ? 36 : 10))
  }

  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    let isPassword = inputType == .password
    return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: isPassword ? 36 : 10))
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    let isPassword = inputType == .password
    return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: isPassword ? 36 : 10))
  }
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 96, height: 46)
  }
  
  func setup() {
    tintColor = .black
    textColor = .black
    font = UIFont.systemFont(ofSize: 14, weight: .regular)
    
    // setup left/ right view
    switch inputType {
    case .email:
      textContentType = .emailAddress
      keyboardType = .emailAddress
      autocapitalizationType = .none
    case .password:
      textContentType = .password
      keyboardType = .default
      autocapitalizationType = .none
      isSecureTextEntry = true
      // Add right view
//      let button = UIButton(type: .system)
//      button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 50)
//      button.setTitle(nil, for: .normal)
//      button.addTarget(self, action: #selector(self.secureButtonTapped(_:)), for: .touchUpInside)
//      rightView = button
//      self.secureButton = button
//      rightViewMode = .always
    case .undefined:
      textContentType = .none
      keyboardType = .default
      autocapitalizationType = .none
    }
    
    // Observe text field editing state
    let observeEditingEvents: () -> Void = { [unowned self] in
      self.addTarget(self, action: #selector(self.editingDidBegin(_:)), for: .editingDidBegin)
      self.addTarget(self, action: #selector(self.editingDidEnd(_:)), for: .editingDidEnd)
    }
    observeEditingEvents()
    
    // Just update after setup
    update()
  }
  
  func update() {
    attributedPlaceholder = NSAttributedString(
      string: placeholder ?? "",
      attributes: [
        .font: UIFont.systemFont(ofSize: 14, weight: .regular),
        .foregroundColor: UIColor(rgb: 0x9F9F9F)
      ]
    )
    secureButton?.setImage(UIImage(systemName: isSecureTextEntry ? "eye.fill" : "eye.slash.fill"), for: .normal)
  }
  
  @objc func secureButtonTapped(_ sender: Any) {
    isSecureTextEntry = !isSecureTextEntry
  }
  
  @objc func editingDidBegin(_ sender: Any) {
    update()
  }
  
  @objc func editingDidEnd(_ sender: Any) {
    update()
  }
}
