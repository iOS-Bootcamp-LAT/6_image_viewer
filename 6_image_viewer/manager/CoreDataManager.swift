//
//  CoreDataManager.swift
//  6_image_viewer
//
//  Created by David Granado Jordan on 6/23/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static var shared = CoreDataManager()

    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "__image_viewer")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}
