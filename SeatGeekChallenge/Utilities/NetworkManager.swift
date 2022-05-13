//
//  NetworkManager.swift
//  SeatGeekChallenge
//
//  Created by Adam Delaney on 5/10/22.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    
    static let clientID = "MjY4NTI2OTB8MTY1MTgwMjAwNy45MzQ0MDU4"
    static let baseURL = "https://api.seatgeek.com/2/events?client_id=" + clientID + "&q="
    
    
    func fetchEvents(search: String, completion: @escaping (Result<[Event], APError>) -> Void) {
        
        guard let url = URL(string: NetworkManager.baseURL + search) else {
            completion(.failure(.invalidURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(.unableToComplete))
            }

            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(response.events))
                } catch let decoderError {
                    print(decoderError)
                    completion(.failure(.decoderError))
                }
                
            }
        }
        task.resume()
    }
    
}


enum APError: Error {
    case invalidURL
    case unableToComplete
    case decoderError
}
