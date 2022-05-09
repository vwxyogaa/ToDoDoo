//
//  FocuseViewController.swift
//  ToDoDoo
//
//  Created by yxgg on 08/05/22.
//

import UIKit

class FocuseViewController: UIViewController {
  var timer = Timer()
  var isTimerStarted = false
  var time = 1500
  
  // MARK: - Views
  lazy var backgroundImage: UIImageView = {
    let backgroundImage = UIImageView()
    backgroundImage.image = UIImage(named: "bgImage")
    backgroundImage.contentMode = .scaleAspectFill
    return backgroundImage
  }()
  
  lazy var timeView: UIView = {
    let timeView = UIView()
    timeView.layer.borderWidth = 15
    timeView.layer.borderColor = UIColor.color1.cgColor
    timeView.layer.cornerRadius = 100
    timeView.layer.masksToBounds = true
    return timeView
  }()
  
  lazy var timeLabel: UILabel = {
    let timeLabel = UILabel()
    timeLabel.text = "25:00"
    timeLabel.textColor = .black
    timeLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
    return timeLabel
  }()
  
  lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.text = "Pomodoro Technique"
    titleLabel.textColor = .black
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 0
    titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    return titleLabel
  }()
  
  lazy var startButton: PrimaryButton = {
    let startButton = PrimaryButton()
    startButton.setTitle("Start Focusing", for: .normal)
    startButton.contentEdgeInsets = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
    return startButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupBackgroundImage()
    setupTimeView()
    setupTimeLabel()
    setupTitleLabel()
    setupStartButton()
  }
  
  // MARK: - Helpers
  private func setupViews() {
    view.backgroundColor = .color3
    title = "Focus"
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
  
  private func setupTimeView() {
    view.addSubview(timeView)
    timeView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      timeView.widthAnchor.constraint(equalToConstant: 200),
      timeView.heightAnchor.constraint(equalToConstant: 200),
      timeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      timeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24)
    ])
  }
  
  private func setupTimeLabel() {
    view.addSubview(timeLabel)
    timeLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      timeLabel.centerXAnchor.constraint(equalTo: timeView.centerXAnchor),
      timeLabel.centerYAnchor.constraint(equalTo: timeView.centerYAnchor)
    ])
  }
  
  private func setupTitleLabel() {
    view.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      titleLabel.topAnchor.constraint(equalTo: timeView.bottomAnchor, constant: 24)
    ])
  }
  
  private func setupStartButton() {
    view.addSubview(startButton)
    startButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24)
    ])
    startButton.addTarget(self, action: #selector(self.setupStartButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func startTimer() {
    timer = Timer.scheduledTimer(
      timeInterval: 1,
      target: self,
      selector: #selector(updateTimer),
      userInfo: nil,
      repeats: true
    )
  }
  
  private func formatTime() -> String {
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format: "%02i:%02i", minutes, seconds)
  }
  
  // MARK: - Actions
  @objc private func setupStartButtonTapped(_ sender: Any) {
    if !isTimerStarted {
      startTimer()
      isTimerStarted = true
      startButton.setTitle("Stop Focusing", for: .normal)
    } else {
      timer.invalidate()
      time = 1500
      isTimerStarted = false
      timeLabel.text = "25:00"
      startButton.setTitle("Start Focusing", for: .normal)
    }
  }
  
  @objc private func updateTimer() {
    time -= 1
    timeLabel.text = formatTime()
  }
}
