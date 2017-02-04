//
//  ViewController.swift
//  GroceryList
//
//  Created by Ethan Hess on 1/8/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let kDetailSegue = "detailSegue"

    @IBOutlet var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refresh()
    }
    
    func refresh() {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addItemTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Item title"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Item description"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Item quantity"
        }
        
        alertController.textFields?[2].keyboardType = UIKeyboardType.decimalPad
        
        let okayAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            
            //add to core data
            let itemTitle = alertController.textFields?[0].text
            let itemDesc = alertController.textFields?[1].text
            let itemQuantity = Int16((alertController.textFields?[2].text)!)
            
            self.saveItemToCoreData(title: itemTitle, itemDescription: itemDesc, quantity: itemQuantity)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okayAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func saveItemToCoreData(title: String?, itemDescription: String?, quantity: Int16?) {
        
        if title != "" && itemDescription != "" && quantity != 0 {
        
        ItemController.sharedInstance.addItemWithTitle(title: title!, itemDescription: itemDescription!, quantity: quantity!)
        
        refresh()
            
        }
        
        else {
            
            print("Please fill in all fields")
        }
    }
    
    func presentEditQuantityAlert(groceryItem: GroceryItem, indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: "New quantity", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Item quantity"
        }
        
        alertController.textFields?[0].keyboardType = UIKeyboardType.decimalPad
        
        let editAction = UIAlertAction(title: "Enter new quantity", style: .default) { (action) in
            
            let amount = alertController.textFields?[0].text
            
            ItemController.sharedInstance.editQuantity(theItem: groceryItem, quantity: Int16(amount!)!)
            self.refresh()
            
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(editAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let groceryItem = ItemController.sharedInstance.groceryItems[indexPath!.row]
        
        if segue.identifier == kDetailSegue {
            
            let destinationVC = segue.destination as! DetailViewController
            
            destinationVC.updateWithItem(groceryItem: groceryItem)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ItemController.sharedInstance.groceryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ItemCell
        
        let groceryItem = ItemController.sharedInstance.groceryItems[indexPath.row]
        
        if groceryItem.isDone == false {
            cell?.theImageView?.image = nil
        }
        else {
            cell?.theImageView?.image = UIImage(named: "checkmarkImage")
        }
        
        cell?.theTitleLabel?.text = "\(groceryItem.quantity) \(groceryItem.title!)"
        cell?.theDetailLabel?.text = groceryItem.itemDescription!
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let groceryItem = ItemController.sharedInstance.groceryItems[indexPath.row]
        
        let alertController = UIAlertController(title: "Options", message: "", preferredStyle: .alert)
        
        let editQuantitiyAction = UIAlertAction(title: "Edit quantity", style: .default) { (action) in
            
            self.presentEditQuantityAlert(groceryItem: groceryItem, indexPath: indexPath)
        }
        
        let setIsDoneAction = UIAlertAction(title: "Check off", style: .default) { (action) in
            
            if groceryItem.isDone == false {
                
                groceryItem.isDone = true
                
                ItemController.sharedInstance.setIsDone(theItem: groceryItem, boolean: true)
                self.refresh()
                
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
                
            else {
                
                groceryItem.isDone = false
                
                ItemController.sharedInstance.setIsDone(theItem: groceryItem, boolean: false)
                self.refresh()
                
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        
        let segueToDetail = UIAlertAction(title: "View detail", style: .default) { (action) in
            
            self.performSegue(withIdentifier: self.kDetailSegue, sender: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Nevermind", style: .cancel, handler: nil)
        
        alertController.addAction(editQuantitiyAction)
        alertController.addAction(setIsDoneAction)
        alertController.addAction(segueToDetail)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            ItemController.sharedInstance.removeItem(item: ItemController.sharedInstance.groceryItems[indexPath.row])
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
}
