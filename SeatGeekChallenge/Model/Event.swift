//
//  Event.swift
//  SeatGeekChallenge
//
//  Created by Adam Delaney on 5/5/22.
//

import Foundation

struct Event: Codable, Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let title: String
    let performers: [Performer]
    let venue: Venue
    let datetime_utc: String
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from:self.datetime_utc)!
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "EEE, dd MMMM yyyy h:mm a"
        let currentDateStr: String = dateFormatter2.string(from: date)
        return currentDateStr
    }
}
