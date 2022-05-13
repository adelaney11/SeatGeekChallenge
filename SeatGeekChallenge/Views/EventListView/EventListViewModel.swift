//
//  EventListViewModel.swift
//  SeatGeekChallenge
//
//  Created by Adam Delaney on 5/10/22.
//

import Foundation

final class EventListViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    @Published var searchText = ""
    @Published var isLoading: Bool = false
    @Published var state: ViewState = .loading
    
    func fetchEvents(){
        self.state = .loading
        
        NetworkManager.shared.fetchEvents(search: self.searchText) { [self] result in
            DispatchQueue.main.async{
                self.state = .loaded
                
                switch result {
                case .success(let events):
                    self.events = events
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        print("The URL was invalid.")
                    case .decoderError:
                        print("There was an error decoding the response from the URL.")
                    case .unableToComplete:
                        print("Something went wrong in fetching this data")
                    }
                }
            }
        }
    }
}

enum ViewState{
    case loading
    case loaded
    case failedToLoad
}
