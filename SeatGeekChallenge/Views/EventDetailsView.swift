//
//  EventDetailsView.swift
//  SeatGeekChallenge
//
//  Created by Adam Delaney on 5/5/22.
//

import SwiftUI

struct EventDetailsView: View {
    
    // for dismissing view
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var store: EventStore
    let event: Event
    @State var favorite: Bool = false
    
    var body: some View {
        
        ZStack{
            Color(red: 49/255, green: 65/255, blue: 76/255)
                .ignoresSafeArea(edges: .top)
            VStack{
                ZStack{
                    Color.white
                    VStack{
                        HStack{
                            Text(event.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding()
                            Spacer()
                            Button(action:{
                                if favorite {
                                    self.favorite = false
                                    self.store.favorites.removeAll{ $0 == event }
                                } else {
                                    self.favorite = true
                                    self.store.favorites.append(event)
                                }
                                
                            }, label:{
                                if favorite {
                                    Image(systemName: "heart.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.red)
                                        .padding()
                                } else {
                                    Image(systemName: "heart")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.red)
                                        .padding()
                                }
                            })
                        }
                        AsyncImage(url: URL(string: event.performers[0].image)){ image in
                            image.resizable()
                            
                        } placeholder: {
                            ProgressView()
                        }
                        .cornerRadius(5)
                        .frame(width: 250, height: 250)
                        VStack(alignment: .leading){
                            Text(event.getDate())
                                .padding(.leading)
                            Text("\(event.venue.city), \(event.venue.state)")
                                .padding(.leading)
                        }
                        Spacer()
                    }
                }
            }
        }.onAppear{
            if self.store.favorites.contains(event) {
                self.favorite = true
            } else {
                self.favorite = false
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                })
            }
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Details")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(event: Event(id: 79879, title: "Oh YEAH!", performers: [Performer(name: "Adam", image: "https://ca-times.brightspotcdn.com/dims4/default/724f37a/2147483647/strip/true/crop/2200x2053+0+0/resize/1486x1387!/quality/90/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Fzbk%2Fdamlat_images%2FLA%2FLA_PHOTO_SELECTS%2FSDOCS%285%29%2Flsfn2epd.JPG")], venue: Venue(name: "KEgger", city: "Los Angeles", state: "CA"), datetime_utc: "2012-03-10T00:00:00")).environmentObject(EventStore())
    }
}
