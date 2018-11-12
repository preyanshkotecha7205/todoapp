//
//  EditTaskViewController.swift
//  todoapp
//
//  Created by Preyansh Kotecha on 11/2/18.
//  Copyright © 2018 preyansh. All rights reserved.
//

import UIKit
import CoreData

class EditTaskViewController: UIViewController {
    
    @IBOutlet weak var editedTitle: UITextView!
    
    var actualTitle: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        editedTitle.text! = actualTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func doneButtonClicked(_ sender: Any) {
        
        let title = editedTitle.text! as! String
        
        self.update(title)
        
       
        
    }
    
    func update(_ title: String!) {
        
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
                if taskTitle == self.actualTitle {
                    
                    obj.setValue(title, forKey:"title")
                    
                }
                
                
            }
            
            do {
                try managedContext.save()
                
                
            }
                
            catch {
                print (error)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
    }
    
    
}
