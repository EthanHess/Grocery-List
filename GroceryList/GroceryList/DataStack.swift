//
//  DataStack.swift
//  GroceryList
//
//  Created by Ethan Hess on 1/8/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit
import CoreData

class DataStack: NSObject {

    var managedObjectContext : NSManagedObjectContext!
    
    override init() {
        super.init()
        
        setUpMOC()
    }
    
    class var sharedInstance: DataStack {
        
        struct Static {
            static let instance: DataStack = DataStack()
        }
        return Static.instance
    }
    
    func setUpMOC() {
        
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        self.managedObjectContext!.persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel())
        
        let error: NSErrorPointer = nil
        
        do {
            try self.managedObjectContext!.persistentStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.storeURL(), options: nil)
        } catch let error1 as NSError {
            error?.pointee = error1
        }
    }
    
    func storeURL () -> URL? {
        
        let documentsDirectory = try? FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: true)
        
        return documentsDirectory?.appendingPathComponent("db.sqlite")
    }
    
    func modelURL () -> URL {
        return Bundle.main.url(forResource: "Model", withExtension: "momd")!
    }
    
    func managedObjectModel () -> NSManagedObjectModel {
        return NSManagedObjectModel(contentsOf: self.modelURL())!
    }
}
