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
        List(watchSessionManager.kencanSet) { item in
            VStack(alignment: .leading) {
                Text("Emoji pertama \(item.topicName)")
                Text("\(item.topicList.joined(separator: ", "))")
            }
        }
    }
}
struct KencanData: Identifiable {
    var id = UUID()
    var topicName: String
    var topicList: [String]
    
    #Preview {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
