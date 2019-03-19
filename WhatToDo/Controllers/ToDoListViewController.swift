//
//  ViewController.swift
//  WhatToDo
//
//  Created by Dendy Darin on 18/03/19.
//  Copyright © 2019 Darinholic. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    //membuat konstanta userdefault
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let newItem = Item()
        newItem.title = "Belajar iOS"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Asyik Sekali"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Keren Banget"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        
    }
    
    //MARK - Buat Metode TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary Operator ===>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        // Rumus Ternary di atas dari statemen if di bawah ini:
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
        
    }
    
    //MARK - TableView Delegate Method untuk delegasi cek dan uncek list yang dipilih
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        

        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Menambah Item Baru
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //Membuat variabel baru untuk scope addbuttonpressed
        var textField = UITextField()
        
        //Membuat konstanta alert
        let alert = UIAlertController(title: "Menambah Item WhatToDo", message: "", preferredStyle: .alert)
        
        //Membuat konstanta action
        let action = UIAlertAction(title: "Menambah Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            //Apa yang terjadi setelah user klik add button di UIAlert
            self.itemArray.append(newItem)
            
            //set userdefault untuk save item list
            self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
            
            //Jurus untuk memasukkan item baru dari textfield
            self.tableView.reloadData()
        }
        
        //Membuat textfield agar user bisa mengisi Item baru
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Masukkan item baru"
            textField = alertTextField
            
        }
        
        //Membuat deklarasi hubungan antara alert dan action
        alert.addAction(action)
        
        //Mempresentasikan alert
        present(alert, animated: true, completion: nil)
    }
    


}

