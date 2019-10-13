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
    
    //MARK - frist used user defaults
    
    // let defaults = UserDefaults.standard
    
      let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      
      
       
        
        
        // UserDefaults
        /*
         if let dataSved = defaults.array(forKey: "TodoListArray") as? [Item] {
         itemArray = dataSved
         }
         */
        
        //  Decoder
        loadItems()
        
        
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
        saveItems()
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
                
                //  UserDefaults
                // self.defaults.set(self.itemArray, forKey: "TodoListArray")
                
               // used Encoder
                self.saveItems()
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func saveItems()  {
        
        //Encoder
        let encoder = PropertyListEncoder()
        do {
            let data  = try encoder.encode(itemArray)
            try  data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    
    func loadItems() {
        
        //Decoder
        
        if let data =  try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
             itemArray = try decoder.decode([Item].self, from:data)
            }catch{
                print("Error decoding item array\(error)")
                
            }
        }
       
        
        
    }
    
    
    
    
    
}

