//
//  ContentView.swift
//  SeatGeekChallenge
//
//  Created by Adam Delaney on 5/5/22.
//

import SwiftUI

struct EventListView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var store: EventStore
    @StateObject private var viewModel = EventListViewModel()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color(red: 49/255, green: 65/255, blue: 76/255)
                    .ignoresSafeArea(edges: .top)
                VStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(red: 1/255, green: 8/255, blue: 22/255))
                        HStack {
                             Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("", text: $viewModel.searchText)
                                .placeholder(when: viewModel.searchText.isEmpty) {
                                        Text("Search...").foregroundColor(.white)
                                }
                                .foregroundColor(.white)
                                
                            Button(action: {
                                self.viewModel.searchText = ""
                            }){
                                Image(systemName: "xmark.circle.fill")
                                    .padding()
                            }
                         }
                             .foregroundColor(.gray)
                             .padding(.leading, 13)
                    }
                    .frame(height: 40)
                    .cornerRadius(13)
                    .padding()
                    ZStack{
                        Color.white
                        switch viewModel.state {
                        case .loading:
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                                .scaleEffect(2)
                        case .failedToLoad:
                            VStack{
                                Image(systemName: "exclamationmark.square.fill")
                                    .foregroundColor(.red)
                                Text("Failed to load events.")
                                Button(action: {
                                    viewModel.fetchEvents()
                                }, label: {
                                    Text("RETRY")
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .cornerRadius(15)
                                })
                            }
                        case .loaded:
                            ScrollView {
                                ForEach(viewModel.events, id: \.id) { event in
                                    NavigationLink(destination: EventDetailsView(event: event)){
                                        EventCellView(event: event)
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }.onAppear{
            EventStore.load{ result in
                switch result {
                case .failure(let error):
                    fatalError(error.localizedDescription)
                case .success(let favorites):
                    store.favorites = favorites
                }
            }
            viewModel.fetchEvents()
        }.onChange(of: viewModel.searchText, perform: { _ in
            viewModel.fetchEvents()
        })
        .onChange(of: scenePhase, perform: { phase in
            if phase == .inactive{
                EventStore.save(favorites: store.favorites){ result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
            }
        })
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView().environmentObject(EventStore())
    }
}
