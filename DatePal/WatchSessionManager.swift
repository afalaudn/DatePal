//
//  WatchSessionManager.swift
//  DatePal
//
//  Created by Afif Alaudin on 26/05/24.
//

import Foundation
import WatchConnectivity
import CoreData

class WatchSessionManager: NSObject, WCSessionDelegate {
    static let shared = WatchSessionManager()
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func sendCoreDataUpdate(kencanSet: [Kencan]) {
        guard WCSession.default.isReachable else { return }

        let data = kencanSet.map { _ in ["kencanSet"] as? [[String: String]] }
        WCSession.default.sendMessage(["kencanSet": data], replyHandler: nil) { error in
            print("Failed to send message: \(error)")
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // Handle received message if necessary
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Handle session activation
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        // Handle session becoming inactive
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Handle session deactivation
        WCSession.default.activate()
    }
}
