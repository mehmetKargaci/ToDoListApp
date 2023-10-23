//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Mehmet on 16.10.23.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
      
    var itemArray = [Item]()

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        loadItems()

        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableview: UITableView, numberOfRowsInSection: Int) -> Int {
        return itemArray.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        
        cell.textLabel!.text = itemArray[indexPath.row].title

        cell.accessoryType = itemArray[indexPath.row].done == true ? .checkmark : .none

        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        //tableView.reloadData() //it exist inside saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    //MARK: - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoList Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
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

        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")

        }
        
        self.tableView.reloadData()
    }
        
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){

        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching dat from context \(error)")
        }
        tableView.reloadData()

    }
    
}
//MARK: - Search bar methods

extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.predicate = predicate
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!) //two become one
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        loadItems(with: request) // we can simply refactor follwing code bei calling the function

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
            
            
        }
    }
}


