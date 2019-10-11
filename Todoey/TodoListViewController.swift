//
//  ViewController.swift
//  Todoey
//
//  Created by Mustafa on 10/9/19.
//  Copyright © 2019 Mostafa. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = ["Messi", "Ter Stegen" , "Pique"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray [indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    
    
    //MARK - TableView DataDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none

        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    

    //MARK - Add New Items
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert  = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
             alertTextField.placeholder = "Create New Item"
         textField = alertTextField
            
        }
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           
            if let text = textField.text {
               self.itemArray.append(text)
             self.tableView.reloadData()
                
                
            }
            
        }
       
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
}

