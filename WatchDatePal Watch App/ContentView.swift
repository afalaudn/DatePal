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
        HStack {
            Text("Choose Set")
                .padding(12)
                .frame(maxWidth: .infinity)
                .cornerRadius(8)}
        List(watchSessionManager.kencanSet) { item in
            VStack(alignment: .leading, spacing: 10) {
                Text("Set Emoji pertama: \(item.topicName)")
                    .font(.headline)
                Text("\(item.topicList.joined(separator: ", "))")
                    .font(.subheadline)
            }
            .padding()
        }
    }
}

struct KencanData: Identifiable {
    var id = UUID()
    var topicName: String
    var topicList: [String]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
