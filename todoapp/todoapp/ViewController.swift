//
//  ViewController.swift
//  todoapp
//
//  Created by Preyansh Kotecha on 11/2/18.
//  Copyright © 2018 preyansh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tasks: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! TodoListCell
        
        cell.taskTitle.text! = tasks[indexPath.row]
        
        return cell
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let id = segue.identifier;
        
        if id == "editView" {
            
            let editedView = segue.destination as! EditTaskViewController
            
            let fromView = sender as! AnyObject
            
            let cell = fromView.superview??.superview as! TodoListCell
            let title = cell.taskTitle.text!;
            editedView.actualTitle = title;
            
        }
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.tableView.reloadData()
        tableView.rowHeight = 100;
        tableView.dataSource = self
        tableView.delegate = self
                // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    @IBAction func doneChe(_ sender: Any)
    {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        
        guard let appDelegate =
            
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "TodoList")
        
        do {
            let  taskManagedObj = try managedContext.fetch(fetchRequest)
            setCompletedTask(taskManagedObj)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    
    
      func setCompletedTask(_ managedObj: [NSManagedObject]) {
        
        
        for task in managedObj {
            
            let taskTitle = task.value(forKeyPath: "title") as! String
         
            
            self.tasks.append(taskTitle)
            
           
        }
        
        
    }
    
    
    @IBAction func markComplete(_ sender: Any) {
        
        let from = sender as AnyObject
        
        let cell = from.superview??.superview as! TodoListCell
        
        let indexPath = tableView.indexPath(for:cell)
        
        let indexToRemove = indexPath?.row
        
        let titleName = cell.taskTitle.text!
        
        var task = titleName
        
        CompletedTasks.completed.append(cell.taskTitle.text!)

        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "TodoList")
        
        do {
            let  taskManagedObj = try managedContext.fetch(fetchRequest)
            
            for obj in taskManagedObj {
                
                let taskTitle = obj.value(forKeyPath: "title") as! String
                if tasks[indexToRemove!] == taskTitle {
                    managedContext.delete(obj)
                }
            }
            
            do {
                try managedContext.save()
                tasks.remove(at:indexToRemove!)
                self.save(cell.taskTitle.text!)
                self.tableView.reloadData()
                
                
                
            }
                
            catch {
                print (error)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
    }
    
    func save(_ title: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Completed",
                                       in: managedContext)!
        
        let newTask = NSManagedObject(entity: entity,
                                      insertInto: managedContext)
        
        newTask.setValue(title, forKeyPath: "title")
        
        
        
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
  
    
    
    

}

