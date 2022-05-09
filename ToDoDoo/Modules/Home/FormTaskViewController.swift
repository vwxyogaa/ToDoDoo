//
//  FormTaskViewController.swift
//  ToDoDoo
//
//  Created by yxgg on 08/05/22.
//

import UIKit

class FormTaskViewController: UIViewController {
  var taskId: Int = 0
  
  // MARK: - Views
  lazy var backgroundImage: UIImageView = {
    let backgroundImage = UIImageView()
    backgroundImage.image = UIImage(named: "bgImage")
    backgroundImage.contentMode = .scaleAspectFill
    return backgroundImage
  }()
  
  lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.textColor = .black
    titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    titleLabel.numberOfLines = 1
    return titleLabel
  }()
  
  lazy var titleTaskTextField: CustomTextField = {
    let titleTaskTextField = CustomTextField(inputType: .undefined)
    titleTaskTextField.placeholder = "Title Task"
    titleTaskTextField.backgroundColor = .white
    titleTaskTextField.layer.cornerRadius = 10
    titleTaskTextField.layer.masksToBounds = true
    return titleTaskTextField
  }()
  
  lazy var descTaskTextField: CustomTextField = {
    let descTaskTextField = CustomTextField(inputType: .undefined)
    descTaskTextField.placeholder = "Description Task"
    descTaskTextField.backgroundColor = .white
    descTaskTextField.layer.cornerRadius = 10
    descTaskTextField.layer.masksToBounds = true
    return descTaskTextField
  }()
  
  lazy var addTaskButton: UIButton = {
    let addTaskButton = UIButton(type: .system)
    addTaskButton.contentEdgeInsets = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
    addTaskButton.setTitle("Add Task", for: .normal)
    addTaskButton.setTitleColor(UIColor.white, for: .normal)
    addTaskButton.backgroundColor = .color1
    addTaskButton.layer.cornerRadius = 5
    addTaskButton.layer.masksToBounds = true
    return addTaskButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupBackgroundImage()
    setupTitleLabel()
    setupTitleTaskTextField()
    setupDescTaskTextField()
    setupAddTaskButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupForm()
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
  
  private func loadTask() {
    TaskProvider.shared.getTask(taskId) { tasks in
      DispatchQueue.main.async {
        self.titleTaskTextField.text = tasks.titleTask
        self.descTaskTextField.text = tasks.descriptionTask
      }
    }
  }
  
  private func setupForm() {
    if taskId > 0 {
      titleLabel.text = "Update Task"
      addTaskButton.setTitle("Update", for: .normal)
      loadTask()
    } else {
      titleLabel.text = "Create New Task"
      addTaskButton.setTitle("Create", for: .normal)
    }
  }
  
  private func setupTitleLabel() {
    view.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24)
    ])
  }
  
  private func setupTitleTaskTextField() {
    view.addSubview(titleTaskTextField)
    titleTaskTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleTaskTextField.heightAnchor.constraint(equalToConstant: 46),
      titleTaskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      titleTaskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      titleTaskTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24)
    ])
  }
  
  private func setupDescTaskTextField() {
    view.addSubview(descTaskTextField)
    descTaskTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      descTaskTextField.heightAnchor.constraint(equalToConstant: 52),
      descTaskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      descTaskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      descTaskTextField.topAnchor.constraint(equalTo: titleTaskTextField.bottomAnchor, constant: 10)
    ])
  }
  
  private func setupAddTaskButton() {
    view.addSubview(addTaskButton)
    addTaskButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      addTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      addTaskButton.topAnchor.constraint(equalTo: descTaskTextField.bottomAnchor, constant: 24)
    ])
    addTaskButton.addTarget(self, action: #selector(self.addTaskButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func saveTask() {
    guard let titleTask = titleTaskTextField.text, titleTask != "" else {
      alert("Field title task is empty")
      return
    }
    
    guard let descTask = descTaskTextField.text, descTask != "" else {
      alert("Field description task is empty")
      return
    }
    
    if taskId > 0 {
      TaskProvider.shared.updateTask(taskId, titleTask, descTask) {
        DispatchQueue.main.async {
          let alert = UIAlertController(title: "Successful", message: "Task updated", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
          })
          self.present(alert, animated: true, completion: nil)
        }
      }
    } else {
      TaskProvider.shared.createTask(titleTask, descTask) {
        DispatchQueue.main.async {
          let alert = UIAlertController(title: "Successful", message: "New task created", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
          })
          self.present(alert, animated: true, completion: nil)
        }
      }
    }
  }
  
  func alert(_ message: String) {
    let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(alertAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
  // MARK: - Actions
  @objc private func addTaskButtonTapped(_ sender: Any) {
    saveTask()
  }
}
