//
//  ViewController.swift
//  Todoey
//
//  Created by Mustafa on 10/9/19.
//  Copyright © 2019 Mostafa. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
 
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let dataSved = defaults.array(forKey: "TodoListArray") as? [Item] {
        itemArray = dataSved
        }
 
 
        
        let newItem = Item()
        newItem.title = "Messi"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Ter Stegen"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Pique"
        itemArray.append(newItem3)
        
        
    }
    
    //MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      //  let cell = UITableViewCell.init(style: .default, reuseIdentifier: "ToDoItemCell")
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary Operator
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none

        return cell

        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    
    
    
    
    //MARK - TableView DataDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
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
                let newItem = Item()
                
                newItem.title = text
                
               self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
             self.tableView.reloadData()
                
                
            }
            
        }
       
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
}

