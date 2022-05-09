//
//  TaskProvider.swift
//  ToDoDoo
//
//  Created by yxgg on 08/05/22.
//

import CoreData

class TaskProvider {
  static let shared: TaskProvider = TaskProvider()
  private init() { }
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "ToDoDoo")
    
    container.loadPersistentStores { _, error in
      guard error == nil else {
        fatalError("Unresolved error \(error!)")
      }
    }
    container.viewContext.automaticallyMergesChangesFromParent = false
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.shouldDeleteInaccessibleFaults = true
    container.viewContext.undoManager = nil
    
    return container
  }()
  
  private func newTaskContext() -> NSManagedObjectContext {
    let taskContext = persistentContainer.newBackgroundContext()
    taskContext.undoManager = nil
    
    taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    return taskContext
  }
  
  func getAllTask(completion: @escaping(_ tasks: [TaskModel]) -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TaskData")
      do {
        let results = try taskContext.fetch(fetchRequest)
        var tasks: [TaskModel] = []
        for result in results {
          let task = TaskModel(
            id: result.value(forKeyPath: "id") as? Int64,
            titleTask: result.value(forKeyPath: "titleTask") as? String,
            descriptionTask: result.value(forKeyPath: "descriptionTask") as? String
          )
          tasks.append(task)
        }
        completion(tasks)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
  }
  
  func getTask(_ id: Int, completion: @escaping(_ tasks: TaskModel) -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TaskData")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      do {
        if let result = try taskContext.fetch(fetchRequest).first {
          let task = TaskModel(
            id: result.value(forKeyPath: "id") as? Int64,
            titleTask: result.value(forKeyPath: "titleTask") as? String,
            descriptionTask: result.value(forKeyPath: "descriptionTask") as? String
          )
          completion(task)
        }
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
  }
  
  func createTask(
    _ titleTask: String,
    _ descTask: String,
    completion: @escaping() -> Void
  ) {
    let taskContext = newTaskContext()
    taskContext.performAndWait {
      if let entity = NSEntityDescription.entity(forEntityName: "TaskData", in: taskContext) {
        let task = NSManagedObject(entity: entity, insertInto: taskContext)
        self.getMaxId { id in
          task.setValue(id+1, forKeyPath: "id")
          task.setValue(titleTask, forKeyPath: "titleTask")
          task.setValue(descTask, forKeyPath: "descriptionTask")
          do {
            try taskContext.save()
            completion()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
        }
      }
    }
  }
  
  func updateTask(
    _ id: Int,
    _ titleTask: String,
    _ descTask: String,
    completion: @escaping() -> Void
  ) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TaskData")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      if let result = try? taskContext.fetch(fetchRequest), let task = result.first as? TaskData {
        task.setValue(titleTask, forKeyPath: "titleTask")
        task.setValue(descTask, forKeyPath: "descriptionTask")
        do {
          try taskContext.save()
          completion()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
      }
    }
  }
  
  func getMaxId(completion: @escaping(_ maxId: Int) -> Void) {
    let taskContext = newTaskContext()
    taskContext.performAndWait {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TaskData")
      let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
      fetchRequest.sortDescriptors = [sortDescriptor]
      fetchRequest.fetchLimit = 1
      do {
        let lastTask = try taskContext.fetch(fetchRequest)
        if let task = lastTask.first, let position = task.value(forKeyPath: "id") as? Int{
          completion(position)
        } else {
          completion(0)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func deleteAllTask(completion: @escaping() -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskData")
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      batchDeleteRequest.resultType = .resultTypeCount
      if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
        if batchDeleteResult.result != nil {
          completion()
        }
      }
    }
  }
  
  func deleteTask(_ id: Int, completion: @escaping() -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskData")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      batchDeleteRequest.resultType = .resultTypeCount
      if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
        if batchDeleteResult.result != nil {
          completion()
        }
      }
    }
  }
}
