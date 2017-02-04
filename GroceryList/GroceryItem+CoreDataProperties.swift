//
//  GroceryItem+CoreDataProperties.swift
//  GroceryList
//
//  Created by Ethan Hess on 1/8/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import Foundation
import CoreData


extension GroceryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryItem> {
        return NSFetchRequest<GroceryItem>(entityName: "GroceryItem");
    }

    @NSManaged public var title: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var itemDescription: String?
    @NSManaged public var isDone: Bool

}
