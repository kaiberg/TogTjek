//
//  Trips.swift
//  TogTjek
//
//  Created by kai delay on 15/08/2023.
//

import SwiftUI

struct Trips: View {    
    var body: some View {
        
        List {
            UpcomingList()
            ProminentTripView()
            TripsList(title: "Departures", trips: SampleData.departureTrips)
            TripsList(title: "Arrivals", trips: SampleData.homeTrips)
        }
    }
}

struct TripsList: View {
    var title: LocalizedStringKey
    var trips: [IdentifiableString]
    
    var body: some View {
        Section {
            ForEach(trips) { trip in
                NavigationLink(trip.name, value: trip)
            }
        } header: {
            Text(title)
        }
        
    }
    
}

#Preview {
    Trips()
}
