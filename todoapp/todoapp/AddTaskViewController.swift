//
//  AddTaskViewController.swift
//  todoapp
//
//  Created by Preyansh Kotecha on 11/2/18.
//  Copyright © 2018 preyansh. All rights reserved.
//
import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    
    
    @IBOutlet weak var taskTitle: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addButtonClicked(_ sender: Any) {
        
         let taskName = taskTitle.text! as! String
        
        self.save(taskName)
        
        
    }
    
    func save(_ title: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "TodoList",
                                       in: managedContext)!
        
        let newTask = NSManagedObject(entity: entity,
                                      insertInto: managedContext)
        
        // 3
        newTask.setValue(title, forKeyPath: "title")
        
        
        
        // 4
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    

}
