//
//  SecondaryButton.swift
//  ToDoDoo
//
//  Created by yxgg on 06/05/22.
//

import UIKit

class SecondaryButton: UIButton {
  convenience init() {
    self.init(type: .system)
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
  
  func setup() {
    tintColor = .color2
    titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
  }
}
