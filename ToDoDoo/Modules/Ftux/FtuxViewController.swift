//
//  FtuxViewController.swift
//  ToDoDoo
//
//  Created by yxgg on 06/05/22.
//

import UIKit

class FtuxViewController: UIViewController {
  // MARK: - Views
  lazy var backgroundImage: UIImageView = {
    let backgroundImage = UIImageView()
    backgroundImage.image = UIImage(named: "bgImage")
    backgroundImage.contentMode = .scaleAspectFill
    return backgroundImage
  }()
  
  lazy var thumbImage: UIImageView = {
    let thumbImage = UIImageView()
    thumbImage.image = UIImage(named: "thumbImage")
    thumbImage.contentMode = .scaleAspectFill
    return thumbImage
  }()
  
  lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.text = "Things To Do With ToDoDoo"
    titleLabel.textAlignment = .center
    titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    titleLabel.textColor = .black
    return titleLabel
  }()
  
  lazy var subtitleLabel: UILabel = {
    let subtitleLabel = UILabel()
    subtitleLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ullamcorper leo in eros parturient arcu odio diam. Gravida faucibus ac mauris et risus."
    subtitleLabel.textAlignment = .center
    subtitleLabel.numberOfLines = 0
    subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    subtitleLabel.textColor = .color4
    return subtitleLabel
  }()
  
  lazy var getStartedButton: PrimaryButton = {
    let getStartedButton = PrimaryButton()
    getStartedButton.setTitle("Get Started", for: .normal)
    return getStartedButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupBackgroundImage()
    setupThumbImage()
    setupTitleLabel()
    setupSubtitleLabel()
    setupGetStartedButton()
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
      backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
    ])
  }
  
  private func setupThumbImage() {
    view.addSubview(thumbImage)
    thumbImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      thumbImage.heightAnchor.constraint(equalToConstant: 170),
      thumbImage.widthAnchor.constraint(equalToConstant: 170),
      thumbImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      thumbImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150)
    ])
  }
  
  private func setupTitleLabel() {
    view.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      titleLabel.topAnchor.constraint(equalTo: thumbImage.bottomAnchor, constant: 80)
    ])
  }
  
  private func setupSubtitleLabel() {
    view.addSubview(subtitleLabel)
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24)
    ])
  }
  
  private func setupGetStartedButton() {
    view.addSubview(getStartedButton)
    getStartedButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      getStartedButton.heightAnchor.constraint(equalToConstant: 56),
      getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      getStartedButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 60),
      getStartedButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
    ])
    getStartedButton.addTarget(self, action: #selector(self.getStartedButtonTapped(_:)), for: .touchUpInside)
  }
  
  // MARK: - Actions
  @objc private func getStartedButtonTapped(_ sender: Any) {
    let viewController = SignInViewController()
    let navigationController = UINavigationController(rootViewController: viewController)
    let window = view.window?.windowScene?.keyWindow
    window?.rootViewController = navigationController
  }
}
