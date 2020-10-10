//
//  CreateData.swift
//  Image Finder
//
//  Created by Pritam Hazra on 10/10/20.
//  Copyright © 2020 Pritam Hazra. All rights reserved.
//

import Foundation
import UIKit
import CoreData


/// Create Data for any entity
/// - Parameters:
///   - entityName: The name of the entity
///   - dictionary: Contains the attributes as key and values
func createData(entityName: String, dictionary: [String:Any]) {
    //As we know that container is set up in the AppDelegates so we need to refer that container.
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    //We need to create a context from this container
    let managedContext = appDelegate.persistentContainer.viewContext
    
    //Now let’s create an entity and new user records.
    let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
    
    //final, we need to add some data to our newly created record for each keys using
    
    let obj = NSManagedObject(entity: entity, insertInto: managedContext)
    for (key,value) in dictionary {
        obj.setValue(value, forKey: key)
    }
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd hh:mm:ss"
    let now = df.string(from: Date())
    obj.setValue(now, forKey: "date")

    //Now we have set all the values. The next step is to save them inside the Core Data
    do {
        try managedContext.save()
       
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

