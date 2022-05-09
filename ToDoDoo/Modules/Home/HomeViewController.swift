//
//  HomeViewController.swift
//  ToDoDoo
//
//  Created by yxgg on 06/05/22.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
  var tasks: [TaskModel] = []
  var taskId: Int = 0
  
  // MARK: - Views
  lazy var backgroundImage: UIImageView = {
    let backgroundImage = UIImageView()
    backgroundImage.image = UIImage(named: "bgImage")
    backgroundImage.contentMode = .scaleAspectFill
    return backgroundImage
  }()
  
  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.backgroundColor = .clear
    tableView.separatorStyle = .none
    return tableView
  }()
  
  lazy var addTaskButton: UIButton = {
    let addTaskButton = UIButton(type: .system)
    addTaskButton.setTitle(nil, for: .normal)
    addTaskButton.setImage(UIImage(systemName: "plus"), for: .normal)
    addTaskButton.tintColor = .white
    addTaskButton.backgroundColor = .color1
    addTaskButton.layer.cornerRadius = 25
    addTaskButton.layer.masksToBounds = true
    return addTaskButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupBackgroundImage()
    setupTableView()
    setupAddTaskButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadTasks()
  }
  
  // MARK: - Helpers
  private func loadTasks() {
    TaskProvider.shared.getAllTask { tasks in
      DispatchQueue.main.async {
        self.tasks = tasks
        self.tableView.reloadData()
      }
    }
  }
  
  private func setupViews() {
    view.backgroundColor = .color3
    title = "ToDoDoo"
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
  
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
    tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "taskCellId")
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  private func setupAddTaskButton() {
    view.addSubview(addTaskButton)
    addTaskButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      addTaskButton.widthAnchor.constraint(equalToConstant: 50),
      addTaskButton.heightAnchor.constraint(equalToConstant: 50),
      addTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      addTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
    ])
    addTaskButton.addTarget(self, action: #selector(self.addTaskButtonTapped(_:)), for: .touchUpInside)
  }
  
  // MARK: - Actions
  @objc private func addTaskButtonTapped(_ sender: Any) {
    let viewController = FormTaskViewController()
    viewController.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  @objc private func userButtonTapped(_ sender: Any) {
    let viewController = AccountViewController()
    viewController.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 1:
      return tasks.count
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 1:
      if let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellId", for: indexPath) as? TaskTableViewCell {
        let task = tasks[indexPath.row]
        cell.titleLabel.text = task.titleTask
        return cell
      } else {
        return UITableViewCell()
      }
    default:
      return UITableViewCell()
    }
  }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 1 {
      let viewController = DetailViewController()
      viewController.taskId = Int(tasks[indexPath.row].id ?? 0)
      viewController.hidesBottomBarWhenPushed = true
      self.navigationController?.pushViewController(viewController, animated: true)
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    switch section {
    case 0:
      guard let username = Auth.auth().currentUser?.displayName else { return UIView() }
      let view = UIView()
      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
      label.textColor = .black
      label.text = "Hai \(username)"
      view.addSubview(label)
      label.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ])
      
      let userButton = UIButton(type: .system)
      userButton.setTitle(nil, for: .normal)
      userButton.setImage(UIImage(systemName: "person.crop.circle.fill"), for: .normal)
      userButton.tintColor = .black
      userButton.layer.borderWidth = 1
      userButton.layer.borderColor = UIColor.black.cgColor
      userButton.layer.cornerRadius = 20
      userButton.layer.masksToBounds = true
      view.addSubview(userButton)
      userButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        userButton.widthAnchor.constraint(equalToConstant: 40),
        userButton.heightAnchor.constraint(equalToConstant: 40),
        userButton.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 24),
        userButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        userButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ])
      userButton.addTarget(self, action: #selector(self.userButtonTapped(_:)), for: .touchUpInside)
      
      return view
    case 1:
      let view = UIView()
      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
      label.textColor = .black
      label.text = "Task List"
      view.addSubview(label)
      label.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ])
      return view
    default:
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    switch section {
    case 0:
      return 40
    case 1:
      return 40
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return nil
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.0001
  }
}
