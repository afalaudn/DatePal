//
//  Persistence.swift
//  DatePal
//
//  Created by Afif Alaudin on 26/05/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        // Selalu kena disini 10:33 27 Mei 2024
        let newItem = Kencan(context: viewContext)
        let exampleTopicListArray = ["Item 1", "Item 2", "Item 3"]
        
        for _ in 0..<10 {
            newItem.topicName = "Example Topic"
            newItem.topicList = exampleTopicListArray.joined(separator: ",")
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unsolved Error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DatePal") // Change to your Core Data model name
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        } else {
            let storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.DatePal.shared")!.appendingPathComponent("DatePal.sqlite")
            let description = NSPersistentStoreDescription(url: storeURL)
            container.persistentStoreDescriptions = [description]
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
