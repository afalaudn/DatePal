//
//  WatchSessionManager.swift
//  WatchDatePal Watch App
//
//  Created by Afif Alaudin on 27/05/24.
//

import Foundation
import WatchConnectivity
import CoreData
import SwiftUI

class WatchSessionManager: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = WatchSessionManager()
    
    @Published var topicSets: [topicSetData] = []
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        guard let topicSetArray = message["topicSet"] as? [[String: String]] else { return }
        DispatchQueue.main.async {
            self.topicSets = topicSetArray.compactMap { dict in
                guard let topicName = dict["topicName"],
                      let topicList = dict["topicList"] as? [String] else { return nil }
                return topicSetData(topicName: topicName, topicList: topicList)
            }
        }
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Handle session activation
    }
}

#Preview {
    ContentView()
}
