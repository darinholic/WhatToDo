//
//  ViewController.swift
//  WhatToDo
//
//  Created by Dendy Darin on 18/03/19.
//  Copyright © 2019 Darinholic. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Belajar iOS","Mahir IOS","Buat Aplikasi iOS","Jadi iOS Expert"]
    
    //membuat konstanta userdefault
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Menampilkan item baru yang disimpan setelah app terminated
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
        
    }
    
    //MARK - Buat Metode TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    //MARK - TableView Delegate Method untuk delegasi cek dan uncek list yang dipilih
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
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
            //Apa yang terjadi setelah user klik add button di UIAlert
            self.itemArray.append(textField.text!)
            
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

