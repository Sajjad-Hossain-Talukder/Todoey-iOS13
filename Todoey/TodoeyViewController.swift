//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoeyViewController: UITableViewController {
    
    var defaults = UserDefaults.standard
    
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t" ]
    
    
    var tikMark = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaults.setValue(self.itemArray, forKey: "toDoList")
        if let items = defaults.object(forKey: "toDoList") as? [String] {
            itemArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count ;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tikMark[indexPath.row] {
            tikMark[indexPath.row] = false
        } else {
            tikMark[indexPath.row] = true 
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType =  tikMark[indexPath.row] ? .checkmark : .none
        
        tableView.deselectRow(at: indexPath, animated: true )
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textTyped = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {
            tf in
            tf.placeholder = "Create New Habit..."
            textTyped = tf
        })

        let action = UIAlertAction(title: "Add Item", style: .default) { act in
            print( textTyped.text ?? "")
            self.itemArray.append(textTyped.text!)
            
            self.defaults.setValue(self.itemArray, forKey: "toDoList")
            
            
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert,animated: true , completion: nil )
        
    }
    
}

