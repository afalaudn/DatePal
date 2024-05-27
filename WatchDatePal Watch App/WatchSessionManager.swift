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
    
    // kencanSet : items. KencanData : ItemData
    @Published var kencanSet: [KencanData] = []
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        guard let kencanSetArray = message["kencanSet"] as? [[String: Any]] else { return }
        DispatchQueue.main.async {
            self.kencanSet = kencanSetArray.compactMap { dict in
                guard let topicName = dict["topicName"] as? String,
                      let topicList = dict["topicList"] as? [String] else { return nil }
                return KencanData(topicName: topicName, topicList: topicList)
            }
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Handle session activation
    }
}
