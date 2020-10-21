//
//  CoreDataStack.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 10/20/20.
//

import Foundation
import CoreData

class CoreDataStack{
    private let modelName: String
    
    init(modelName: String){
        self.modelName = modelName
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            
            if let error = error {
                fatalError("Unresolved error creating persistent store : \(error): \(error.localizedDescription)")
            }
        })
        
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch {
            fatalError("Unresolved error trying to save the context: \(error) : \(error.localizedDescription)")
        }
    }
    
    func createGroup(from group: TheGroup, for context: NSManagedObjectContext) -> Group {
        
        let newGroup = Group(context: context)
        newGroup.group_name = group.group_name
        newGroup.desc = group.desc
        return newGroup
    }
}

