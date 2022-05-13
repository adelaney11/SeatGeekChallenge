//
//  EventCellView.swift
//  SeatGeekChallenge
//
//  Created by Adam Delaney on 5/5/22.
//

import SwiftUI

struct EventCellView: View {
    
    @EnvironmentObject var store: EventStore
    let event: Event
    @State var favorite: Bool = false
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color.white)
                .frame(width: 350, height: 100)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding(.leading)
                .padding(.trailing)
            HStack{
                ZStack{
                    AsyncImage(url: URL(string: event.performers[0].image)){ image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .cornerRadius(5)
                    .frame(width: 75, height: 75)
                    
                    Button(action: {
                        store.favorites.removeAll(where: {$0 == event})
                    }, label: {
                        ZStack{
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.white)
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(.red)
                        }
                        
                    })
                    .offset(x: -35, y: -35)
                    .opacity(store.favorites.contains(event) ? 1 : 0)
                    .disabled(!store.favorites.contains(event))
                }
                
                VStack(alignment: .leading){
                    Text(event.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                    Text("\(event.venue.city), \(event.venue.state)")
                        .font(.footnote)
                        .foregroundColor(.black)
                    Text(event.getDate())
                        .font(.footnote)
                        .foregroundColor(.black)
                }
                .frame(width: 250, height: 75, alignment: .leading)
            }.padding()
        }
        
    }
}

struct EventCellView_Previews: PreviewProvider {
    static var previews: some View {
        EventCellView(event: Event(id: 79879, title: "Oh YEAH!", performers: [Performer(name: "Adam", image: "https://ca-times.brightspotcdn.com/dims4/default/724f37a/2147483647/strip/true/crop/2200x2053+0+0/resize/1486x1387!/quality/90/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Fzbk%2Fdamlat_images%2FLA%2FLA_PHOTO_SELECTS%2FSDOCS%285%29%2Flsfn2epd.JPG")], venue: Venue(name: "My house.", city: "Los Angeles", state: "CA"), datetime_utc: "2012-03-10T00:00:00"))
    }
}

