//
//  CompletedTasks.swift
//  todoapp
//
//  Created by Preyansh Kotecha on 11/2/18.
//  Copyright © 2018 preyansh. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CompletedTasks {
    
    static var completed:[String] = []
    
    init() {
        
    }
    
    static func fetchData() {
        
        guard let appDelegate =
            
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Completed")
        
        do {
            let  taskManagedObj = try managedContext.fetch(fetchRequest)
            setCompletedTask(taskManagedObj)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    static  func setCompletedTask(_ managedObj: [NSManagedObject]) {
        
        
        for task in managedObj {
            
            let taskTitle = task.value(forKeyPath: "title") as! String
            CompletedTasks.completed.append(taskTitle)
        }
        
        
    }
    
    
}
