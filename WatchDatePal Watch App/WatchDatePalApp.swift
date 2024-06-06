//
//  WatchDatePalApp.swift
//  WatchDatePal Watch App
//
//  Created by Afif Alaudin on 27/05/24.
//

import SwiftUI

@main
struct WatchDatePalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

