//
//  SeatGeekChallengeApp.swift
//  SeatGeekChallenge
//
//  Created by Adam Delaney on 5/5/22.
//

import SwiftUI

@main
struct SeatGeekChallengeApp: App {
    @StateObject var store = EventStore()
    var body: some Scene {
        WindowGroup {
            EventListView().environmentObject(store)
        }
    }
}
