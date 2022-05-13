//
//  Response.swift
//  SeatGeekChallenge
//
//  Created by Adam Delaney on 5/5/22.
//

import Foundation

struct Response: Decodable{
    let events: [Event]
}
