//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoeyViewController: UITableViewController {
    /*
    var defaults = UserDefaults.standard
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask ).first?.appendingPathComponent("Items.plist")
     */
    
    let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    var itemArray = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //print(filePath)
        //loadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count ;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType =   itemArray[indexPath.row].done ?  .checkmark : .none
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done.toggle()
        saveData()
        tableView.deselectRow(at: indexPath, animated: true )
    }
    
    
    //MARK: - Add BUTTON PRESSED

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textTyped = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { tf in
            tf.placeholder = "Create New Habit..."
            textTyped = tf
        })

        let action = UIAlertAction(title: "Add Item", style: .default) { act in
            
            /*
                Codable Class Part :
                 var item = ItemOld(title: textTyped.text ?? "")
                 self.itemArray.append(item)
                 self.saveData()
             */
            
            let newItem = Item(context: self.context)
            newItem.title = textTyped.text
            newItem.done = false 
            self.itemArray.append(newItem)
            self.saveData()
            
        }
        
        alert.addAction(action)
        present(alert,animated: true , completion: nil )
        
    }
    
    //MARK: - SAVE DATA

    
    func saveData() {
        do{
            try context.save()
        } catch {
            print("Error : \(error)")
        }
        
        /*
             let encoder = PropertyListEncoder()
             do {
                 let data = try encoder.encode(self.itemArray)
                 try data.write(to: self.filePath!)
             } catch {
                 print("Catched Array while inserting \(error)")
             }
         */
        
        //self.defaults.setValue(self.itemArray, forKey: "toDoList") // userDefaults Data insert
        self.tableView.reloadData()
    }
    
    //MARK: - Load DATA
    func loadData(){
        
        /*
         
            if let data = try? Data(contentsOf: filePath!){
                let decoder  = PropertyListDecoder()
                do {
                    itemArray = try decoder.decode([ItemOld].self, from: data)
                } catch {
                    print("Errors are \(error)")
                }
               
            }
            -Codable ProperyList to fixed Directory (filePath)
         */
        
       /*
            if let items = defaults.object(forKey: "toDoList") as? [Item] {
                itemArray = items
            }
            - Loading data from userDefaults
        */
    }
    
}



//MARK: - HARD CODED ARRAY
/*
 hardCoded Array:
 //var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t" ]
 //var tikMark = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
 */






