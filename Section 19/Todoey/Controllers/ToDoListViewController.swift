//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Robert Dodson on 04/08/2020.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    var toDoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    //MARK: - UITableView required methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }



    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.itemCellID, for: indexPath)
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.isChecked ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toDoItems?[indexPath.row].isChecked = !toDoItems[indexPath.row].isChecked
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK: - Add new item pressed
    @IBAction func addNewItemPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            newItem.isChecked = false
            newItem.parentCateogry = self.selectedCategory
            self.save(item: newItem)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK: - Save items to CoreData DB
    func save(item: Item) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("Error: \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    //MARK: - Load items from CoreData DB
    func loadItems() {
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    
    
    //MARK: - Extension - UISearchBarDelegate
    extension ToDoListViewController: UISearchBarDelegate {
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
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
}
