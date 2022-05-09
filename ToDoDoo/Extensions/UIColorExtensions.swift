//
//  UIColorExtensions.swift
//  ToDoDoo
//
//  Created by yxgg on 06/05/22.
//

import Foundation
import UIKit

extension UIColor {
  /// #50C2C9
  static var color1: UIColor = UIColor(rgb: 0x50C2C9)
  /// #24D0C6
  static var color2: UIColor = UIColor(rgb: 0x24D0C6)
  /// #F5F5F5
  static var color3: UIColor = UIColor(rgb: 0xF5F5F5)
  /// #5B5B5B
  static var color4: UIColor = UIColor(rgb: 0x5B5B5B)
  
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF
    )
  }
}
