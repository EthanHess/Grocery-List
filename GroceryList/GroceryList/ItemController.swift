//
//  ItemController.swift
//  GroceryList
//
//  Created by Ethan Hess on 1/8/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit
import CoreData

class ItemController: NSObject {
    
    static let sharedInstance = ItemController()
    
    var groceryItems : [GroceryItem] {
        
        get {
            return (try! DataStack.sharedInstance.managedObjectContext.fetch(NSFetchRequest(entityName: "GroceryItem")))
        }
    }
    
    func addItemWithTitle(title: String, itemDescription: String, quantity: Int16) {
        
        let groceryItem = NSEntityDescription.insertNewObject(forEntityName: "GroceryItem", into: DataStack.sharedInstance.managedObjectContext) as! GroceryItem
        
        groceryItem.title = title
        groceryItem.itemDescription = itemDescription
        groceryItem.quantity = quantity
        groceryItem.isDone = false
        
        save()
    }
    
    func setIsDone(theItem: GroceryItem, boolean: Bool) {
        
        theItem.isDone = boolean
        
        save()
    }
    
    func editQuantity(theItem: GroceryItem, quantity: Int16) {
        
        theItem.quantity = quantity
        
        save()
    }
    
    func removeItem(item: GroceryItem) {
        
        item.managedObjectContext?.delete(item)
        
        save()
    }
    
    func save() {
        
        do {
            try DataStack.sharedInstance.managedObjectContext.save()
        }
            
        catch _ {
            //catch error here
        }
    }
}
