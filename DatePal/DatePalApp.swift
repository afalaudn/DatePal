//
//  DatePalApp.swift
//  DatePal
//
//  Created by Afif Alaudin on 26/05/24.
//

import SwiftUI

@main
struct DatePalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomePage()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
