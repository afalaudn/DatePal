//
//  Persistence.swift
//  DatePal
//
//  Created by Afif Alaudin on 26/05/24.
//

//import CoreData
//
//struct PersistenceController {
//    static let shared = PersistenceController()
//    
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        
//        for _ in 0..<10 {
//            let newItem = Kencan(context: viewContext)
//            newItem.topicName = ""
//            newItem.topicList = []
//            
////            newItem.topicName = "Example Topic"
////            // Example topicList as a comma-separated string
////            let exampleTopicListString = "Item 1 ,Item 2, Item 3"
////            // Convert the string to an array of strings
////            let topicListArray = exampleTopicListString.components(separatedBy: ",")
////            // Join the array elements into a single string
////            newItem.topicList = topicListArray.joined(separator: ",")
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unsolved Error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
//    
//    let container: NSPersistentContainer
//    
//    init(inMemory: Bool = false) {
//        container = NSPersistentContainer(name: "DatePal") // Ganti dengan nama model Core Data Anda
//        if inMemory {
//            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
//        } else {
//            let storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.DatePal.shared")!.appendingPathComponent("DatePal.sqlite")
//            let description = NSPersistentStoreDescription(url: storeURL)
//            container.persistentStoreDescriptions = [description]
//        }
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        container.viewContext.automaticallyMergesChangesFromParent = true
//    }
//}

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        for _ in 0..<10 {
            let newItem = Kencan(context: viewContext)
            newItem.topicName = "Example Topic"
            let exampleTopicListArray = ["Item 1", "Item 2", "Item 3"]
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
