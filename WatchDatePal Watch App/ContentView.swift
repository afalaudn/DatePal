//
//  ContentView.swift
//  WatchDatePal Watch App
//
//  Created by Afif Alaudin on 27/05/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var watchSessionManager = WatchSessionManager.shared
    
    var body: some View {
        List(watchSessionManager.topicSets) { item in
            Text("Emoji pertama \(item.topicName) \(item.topicList)")
        }
    }
}
struct topicSetData: Identifiable {
    var id = UUID()
    let topicName: String
    let topicList: [String]
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
