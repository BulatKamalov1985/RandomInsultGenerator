//
//  StorageManager.swift
//  RandomInsultGenerator
//
//  Created by Bulat Kamalov on 11.11.2021.
//

import Foundation

import CoreData

protocol StorageManagerInterface {
    func createEntityFrom(_ element: FuckYouElements)
    func saveContext()
    func fetchInsults() -> [InsultData]?
}

final class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    
    var persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "RandomInsultGenerator")
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        context = persistentContainer.viewContext
    }
    
}

extension StorageManager: StorageManagerInterface {
    func fetchInsults() -> [InsultData]? {
        let fetchRequest: NSFetchRequest<InsultData> = InsultData.fetchRequest()
        return try? context.fetch(fetchRequest)
        
    }
    
    func createEntityFrom(_ element: FuckYouElements) {
        let insult = InsultData(context: context)
        insult.title = element.insult
        
    }
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
                print("an insult have saved")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Save data
    func save(_ insultName: String, completion: (InsultData) -> Void) {
        let insult = InsultData(context: context)
        insult.title = insultName
        
        completion(insult)
        saveContext()
    }
    
    func delete(_ iInsult: InsultData) {
        context.delete(iInsult)
        saveContext()
    }
    
    func edit(_ insult: InsultData, newname: String) {
        insult.title = newname
        saveContext()

    }
}
