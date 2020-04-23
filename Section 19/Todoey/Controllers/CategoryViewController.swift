//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Drew Dodson on 4/19/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    
    //MARK: - Add new item pressed
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            self.saveCategories()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK: - Count items in array for number of categories
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }



    //MARK: - Section Heading
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCellID, for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }



    //MARK: - Prep for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }



    //MARK: - Category was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.segueID, sender: self)
    }



    //MARK: - Load items from CoreData DB
    func loadCategories() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
            do {
                categoryArray = try context.fetch(request)
            } catch {
                print("Error: \(error)")
            }
            tableView.reloadData()
        }



    //MARK: - Save items to CoreData DB
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error: \(error)")
        }
        tableView.reloadData()
    }
    
    
    
}
