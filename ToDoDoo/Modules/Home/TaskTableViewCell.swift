//
//  TaskTableViewCell.swift
//  ToDoDoo
//
//  Created by yxgg on 08/05/22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
  // MARK: - Views
  lazy var checkButton: CustomCheckBox = {
    let checkButton = CustomCheckBox()
    checkButton.tintColor = .color1
    return checkButton
  }()
  
  lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.textColor = .black
    titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    return titleLabel
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
    setupCheckButton()
    setupTitleLabel()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
    setupCheckButton()
    setupTitleLabel()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupViews()
    setupCheckButton()
    setupTitleLabel()
  }
  
  // MARK: - Helpers
  private func setupViews() {
    backgroundColor = .clear
    selectionStyle = .none
  }
  
  private func setupCheckButton() {
    contentView.addSubview(checkButton)
    checkButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      checkButton.widthAnchor.constraint(equalToConstant: 30),
      checkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
      checkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      checkButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
  }
  
  private func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
      titleLabel.centerYAnchor.constraint(equalTo: checkButton.centerYAnchor)
    ])
  }
}
