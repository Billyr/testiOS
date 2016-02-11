//
//  CoreDataStack.swift
//  Dog Walk
//
//  Created by Billy Rangel on 05/02/16.
//  Copyright © 2016 Billy Rangel. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    var context : NSManagedObjectContext
    let psc : NSPersistentStoreCoordinator
    let model : NSManagedObjectModel
    let store : NSPersistentStore
    
    class func applicationDocumentsDirectory() -> NSURL {
        
        let fileManager = NSFileManager.defaultManager()
        
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        
        return urls[urls.count - 1]
    }

    
    init() {
        
        // 1
        
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("OpenLibrary", withExtension: "momd")
        self.model = NSManagedObjectModel(contentsOfURL: modelURL!)!
        
        
        // 2
        
        self.psc = NSPersistentStoreCoordinator(managedObjectModel: self.model)
        
        // 3
        
        self.context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        self.context.persistentStoreCoordinator = psc
        
        // 4
        let documentsURL = CoreDataStack.applicationDocumentsDirectory()
        let storeURL = documentsURL.URLByAppendingPathComponent("OpenLibrary")

        
        let options = [NSMigratePersistentStoresAutomaticallyOption : true]
        
        do {
            
            self.store =  try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: options)
            
        } catch let error {
            print("\(error)")
            abort()
        }
        
        
    } // init
    
    
    func saveContext() {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print(error.description)
                abort()
            }
        }
        
    }
    
    
    
} // Clase



























