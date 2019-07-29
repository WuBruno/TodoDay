//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Bruno Wu on 27/07/2019.
//  Copyright © 2019 Bruno Wu. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    //Optional
    var categoryArray: Results<Category>?
    //Access point to our realm database
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
    
    //Mark: - TableView Datasource Methods
    // Defines the number of rows in the section of the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If nil then it will be 1 as a default
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
    }
    
    //Mark: - Data Manipulation Methods
    
    func loadCategories() {
        //Fetch all the objects that belong to the category object type
        categoryArray = realm.objects(Category.self)
    }
    
    func saveCategories(category : Category) {
        do{
            // The object is added automatically whenever add is calledd
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error encoding item array. \(error)")
        }
    }
    
    //Mark: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // What will happen once the user clicks the Add Item button on our UIAlert
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.saveCategories(category: newCategory)
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //Mark: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }

}
