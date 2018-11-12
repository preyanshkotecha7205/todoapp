//
//  CompletedTableViewController.swift
//  todoapp
//
//  Created by Preyansh Kotecha on 11/2/18.
//  Copyright © 2018 preyansh. All rights reserved.
//

import UIKit
import CoreData

class CompletedTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    
    
    @IBOutlet weak var tableView: UITableView!
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return CompletedTasks.completed.count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doneCell", for: indexPath) as! DoneCell
        
        cell.completedLabel.text = CompletedTasks.completed[indexPath.row]
        
        return cell
    }
    

   
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        

       
    }
    
    
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 100
        self.tableView.reloadData()

    }
    

}
