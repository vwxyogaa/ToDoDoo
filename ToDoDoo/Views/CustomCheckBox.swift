//
//  CustomCheckBox.swift
//  ToDoDoo
//
//  Created by yxgg on 08/05/22.
//

import UIKit

class CustomCheckBox: UIButton {
  // Images
  let checkedImage = UIImage(systemName: "square.fill")
  let uncheckedImage = UIImage(systemName: "square")
  
  // Bool property
  var isChecked: Bool = false {
    didSet {
      update()
    }
  }
  
  convenience init() {
    self.init(frame: .zero)
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
  
  override func awakeFromNib() {
    setup()
  }
  
  @objc func buttonClicked(sender: UIButton) {
    if sender == self {
      isChecked = !isChecked
    }
  }
  
  private func setup() {
    self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
    isChecked = false
  }
  
  private func update() {
    if isChecked == true {
      self.setImage(checkedImage, for: .normal)
    } else {
      self.setImage(uncheckedImage, for: .normal)
    }
  }
}
