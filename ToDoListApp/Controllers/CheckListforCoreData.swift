////
////  CheckListforCoreData.swift
//
//
//AppDelegate:
//
//var window: UIWindow?
//
//func applicationWillTerminate(_ application: UIApplication) {
//    self.saveContext()
//}
//
//
////MARK: - Core Data stack
//
//lazy var persistentContainer: NSPersistentContainer = {
//
//    let container = NSPersistentContainer(name: "DataModel")
//    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//        if let error = error as NSError? {
//
//            fatalError("Unresolved error \(error), \(error.userInfo)")
//        }
//    })
//    return container
//}()
//
//// MARK: - Core Data Saving support
//
//
//func saveContext () {
//    let context = persistentContainer.viewContext
//    if context.hasChanges {
//        do {
//            try context.save()
//        } catch {
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//        }
//    }
//}
//in DataModel
//
//add Item (Class)
//add title and done  (proporties)

// ToDoListViewController;
//let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    
//  print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))


//@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {:
//let newItem = Item(context: self.context)
//newItem.title = textField.text!
//newItem.done = false
//}

//func saveItems(){
//
//    do {
//        try context.save()
//    } catch {
//        print("Error saving context \(error)")
//
//    }
//    
//    self.tableView.reloadData()
//}



//READ
//override func viewDidLoad() {
//    super.viewDidLoad()
//    
//    loadItems()
//    
//    func loadItems(){
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching dat from context \(error)")
//        }
//
//    }


//UPDATE
//itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//
//saveItems()


//DELETE
// the order of code is a huge deal!!!!!
//context.delete(itemArray[indexPath.row])
//itemArray.remove(at: indexPath.row)


//other than READ (Create, update and destroy)
//whenever we need to change the data inside the persistent store, we always need to call
//context.save() to commit those changes.


