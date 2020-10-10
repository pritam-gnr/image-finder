//
//  ReadData.swift
//  Image Finder
//
//  Created by Pritam Hazra on 10/10/20.
//  Copyright © 2020 Pritam Hazra. All rights reserved.
//

import Foundation
import UIKit
import CoreData

///
struct SortBy: Equatable {
    let key: String
    let ascending: Bool
}

struct SearchQuery: Equatable {
    let key: String
    let value: String
}


/// <#Description#>
/// - Parameters:
///   - entityName: Name of the entity to be fetched
///   - search: Array of SearchQuery type structure to specify the query. Default []
///   - fetchLimit: limit of the fetched value. Default 0, which means no limit
///   - sortBy: Array of SortBy type structure for ordering the fetched result. Default []
/// - Returns: Array of dictionary with key of type string and value of type any
func ReadData(entityName: String, search: [SearchQuery] = [], fetchLimit: Int = 0, sortBy: [SortBy] = []) -> [[String: Any]] {
    
    //As we know that container is set up in the AppDelegates so we need to refer that container.
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
    
    //We need to create a context from this container
    let managedContext = appDelegate.persistentContainer.viewContext
    
    //Prepare the request of type NSFetchRequest  for the entity
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    if fetchLimit > 0 {
        fetchRequest.fetchLimit = fetchLimit
    }
    
    if search != [] {
        for item in search {
            fetchRequest.predicate = NSPredicate(format: "\(item.key) BEGINSWITH %@", item.value)
        }
    }
    
    if sortBy != [] {
        fetchRequest.sortDescriptors = []
        for item in sortBy {
            fetchRequest.sortDescriptors!.append(NSSortDescriptor(key: item.key, ascending: item.ascending))
        }
    }
    
    do {
        let result = try managedContext.fetch(fetchRequest)
        var resultDict: [[String:Any]] = []
        for data in result as! [NSManagedObject] {
            var dict: [String: Any] = [:]
            for attribute in data.entity.attributesByName {
                dict[attribute.key] = data.value(forKey: attribute.key)
            }
            resultDict.append(dict)
        }
        return resultDict
    } catch {
        print("Failed")
        return []
    }
}
