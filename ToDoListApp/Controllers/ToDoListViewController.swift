//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Mehmet on 16.10.23.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    //var itemArray = ["E", "M", "I", "Mehmet"]
    
    var itemArray = [Item]()
    
    //let defaults = UserDefaults.standard //we will use NSCoder instead of this
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        print(dataFilePath)
        
//        let newItem = Item()
//        newItem.title = "Mia The Cat"
//        newItem.done = true
//        itemArray.append(newItem)
//        
//        let newItem2 = Item()
//        newItem2.title = "Mia The Cat"
//        itemArray.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "Mia The Cat"
//        itemArray.append(newItem3)
// we have already saved them to the our item.Plist. so we dont need to initialise them.
        
        loadItems()
        
        
        
        //        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
        //            itemArray = items
        //        }
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableview: UITableView, numberOfRowsInSection: Int) -> Int {
        return itemArray.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //print("cellForRowAtIndexPath called")
        
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //let item = itemArray[indexPath.row]
        
        cell.textLabel!.text = itemArray[indexPath.row].title
        
        //Ternary operator: value = condition ? valueifTrue : valueifFalse
        cell.accessoryType = itemArray[indexPath.row].done == true ? .checkmark : .none
        //cell.accessoryType = item.done ? .checkmark : .none //(even more shorter)
        
        
        //            if itemArray[indexPath.row].done == true {
        //                cell.accessoryType = .checkmark
        //            } else {
        //                cell.accessoryType = .none
        //            }
        
        
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        //a single line of code for below
        //            if itemArray[indexPath.row].done == false {
        //                itemArray[indexPath.row].done = true
        //            } else {
        //                itemArray[indexPath.row].done = false
        //            }
        
        
        //        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //
        //        } else{
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //        }
        
        saveItems()
        
        //tableView.reloadData() //it exist inside saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    //MARK: - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoList Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
            
            //print("Succes...add item pressed")
            //print(textField.text!)
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            //self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
            //we wont use userDefaults. instead of upper line we can create encoder
            
            self.saveItems()
            
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            //print(alertTextField.text)
            //print("now")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    //MARK: - Model Manupulation Methods

    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array \(error)")
        }
        
        self.tableView.reloadData()
    }
        
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Decoding error of item array\(error)")
            }
            
        }
        
        
    }
    
}
