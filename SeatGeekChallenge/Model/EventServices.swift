//
//  EventServices.swift
//  SeatGeekChallenge
//
//  Created by Adam Delaney on 5/5/22.
//

import Foundation

protocol EventServicesProtocol: AnyObject {
    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void)
    func filterEvents()
}

class EventServices: EventServicesProtocol {
    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        
        let clientID = "MjY4NTI2OTB8MTY1MTgwMjAwNy45MzQ0MDU4"
        
        let url = URL(string: "https://api.seatgeek.com/2/events?client_id=" + clientID + "&q=swift")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(error))
            }

            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(response.events))
                } catch let decoderError {
                    print(decoderError)
                    completion(.failure(decoderError))
                }
                
            }
        }
        task.resume()
    }
    
    
    func filterEvents() {
        //do something
    }
}
