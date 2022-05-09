//
//  DetailViewController.swift
//  ToDoDoo
//
//  Created by yxgg on 08/05/22.
//

import UIKit

class DetailViewController: UIViewController {
  var taskId: Int = 0
  
  // MARK: - Views
  lazy var backgroundImage: UIImageView = {
    let backgroundImage = UIImageView()
    backgroundImage.image = UIImage(named: "bgImage")
    backgroundImage.contentMode = .scaleAspectFill
    return backgroundImage
  }()
  
  lazy var titleTask: UITextView = {
    let titleTask = UITextView()
    titleTask.isScrollEnabled = false
    titleTask.isEditable = false
    titleTask.textColor = .black
    titleTask.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    titleTask.backgroundColor = .white
    titleTask.layer.cornerRadius = 10
    titleTask.layer.masksToBounds = true
    titleTask.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    return titleTask
  }()
  
  lazy var descriptonTask: UITextView = {
    let descriptionTask = UITextView()
    descriptionTask.isScrollEnabled = false
    descriptionTask.isEditable = false
    descriptionTask.textColor = .black
    descriptionTask.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    descriptionTask.backgroundColor = .white
    descriptionTask.layer.cornerRadius = 10
    descriptionTask.layer.masksToBounds = true
    descriptionTask.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    return descriptionTask
  }()
  
  lazy var editButton: UIButton = {
    let editButton = UIButton(type: .system)
    editButton.setTitle(" Edit Task", for: .normal)
    editButton.setTitleColor(UIColor.black, for: .normal)
    editButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
    editButton.tintColor = .black
    return editButton
  }()
  
  lazy var deleteButton: UIButton = {
    let deleteButton = UIButton(type: .system)
    deleteButton.setTitle(" Delete Task", for: .normal)
    deleteButton.setTitleColor(UIColor.red, for: .normal)
    deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
    deleteButton.tintColor = .red
    return deleteButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupBackgroundImage()
    setupTitleTask()
    setupDescriptionTask()
    setupEditButton()
    setupDeleteButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadTasks()
  }
  
  // MARK: - Helpers
  private func setupViews() {
    view.backgroundColor = .color3
    title = "Detail"
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
  
  private func setupTitleTask() {
    view.addSubview(titleTask)
    titleTask.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleTask.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      titleTask.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      titleTask.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24)
    ])
  }
  
  private func setupDescriptionTask() {
    view.addSubview(descriptonTask)
    descriptonTask.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      descriptonTask.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      descriptonTask.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      descriptonTask.topAnchor.constraint(equalTo: titleTask.bottomAnchor, constant: 10)
    ])
  }
  
  private func setupEditButton() {
    view.addSubview(editButton)
    editButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      editButton.topAnchor.constraint(equalTo: descriptonTask.bottomAnchor, constant: 24)
    ])
    editButton.addTarget(self, action: #selector(self.editButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func setupDeleteButton() {
    view.addSubview(deleteButton)
    deleteButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      deleteButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 24)
    ])
    deleteButton.addTarget(self, action: #selector(self.deleteButtonTapped(_:)), for: .touchUpInside)
  }
  
  private func loadTasks() {
    TaskProvider.shared.getTask(taskId) { tasks in
      DispatchQueue.main.async {
        self.titleTask.text = tasks.titleTask
        self.descriptonTask.text = tasks.descriptionTask
      }
    }
  }
  
  private func deleteTasks() {
    TaskProvider.shared.deleteTask(taskId) {
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "Successful", message: "Task deleted.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
          self.navigationController?.popViewController(animated: true)
        })
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
  
  // MARK: - Actions
  @objc private func editButtonTapped(_ sender: Any) {
    guard let title = titleTask.text else { return }
    let alert = UIAlertController(title: "Edit Task", message: """
                                  Are you sure want to change this task?
                                  Task title: \(title)
                                  """, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Edit", style: .default) { _ in
      let viewController = FormTaskViewController()
      viewController.taskId = self.taskId
      self.navigationController?.pushViewController(viewController, animated: true)
    })
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  @objc private func deleteButtonTapped(_ sender: Any) {
    guard let title = titleTask.text else { return }
    let alert = UIAlertController(title: "Delete Task", message: """
                                  Are you sure want to delete this task?
                                  Task title: \(title)
                                  """, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
      self.deleteTasks()
    })
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
