//
//  TripFinder.swift
//  TogTjek
//
//  Created by kai delay on 19/08/2023.
//

import SwiftUI

struct TripFinder: View {
    @Environment(\.dismiss) var dismiss
    @State var from : Location?
    @State var to : Location?
    @State var trips : [TripJ] = []
    @State var time : Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    LocationSelector(location: $from, placeholder: "From")
                    LocationSelector(location: $to, placeholder: "To")
                    TimeSelector(time: $time)
                    
                }
                
                Section {
                    List(trips) { trip in
                        List(trip.leg) { leg in
                            ProminentTripView(trip: leg)
                        }
                    }
                } header: {
                    Text("Results")
                }
            }.refreshable {
                search()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("cancel", role: .cancel, action: dismiss.callAsFunction)
                })
            }
            .navigationTitle("Add trip")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: from) {
                search()
            }
            .onChange(of: to) {
                search()
            }
            .onChange(of: time) {
                search()
            }
        }
    }
    
    func search() {
        if(from == nil || to == nil || time == nil) {
            print("trips from, to, or time is nil")
            return;
        }
        
        Task {
            let trips = await GetTrips.getTrips(origin: from!, destination: to!, date: time)
            print("searched trips, and found these: \(trips)")
            print(trips.first?.leg.first?.name ?? "")
            
            withAnimation {
                self.trips = trips
            }
        }
    }
}

#Preview {
    TripFinder()
}

struct LocationSheet: View {
    @Binding var location : Location?
    @Binding var show: Bool
    @State var text = ""
    @State var locations: [Location] = []
    
    private func search() async {
        locations = await GetLocation.getLocations(searchString: text)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(locations, id: \.id) { location in
                    Text(location.name).onTapGesture {
                        self.location = location
                        show.toggle()
                    }
                }
                
            }
        }
        
        .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search station")
        .onChange(of: text) {
            print(text)
            
            if(text == "Tommerup" || text == "Odense") {
                Task {
                    await search()
                }
            }
            
        }
    }
}

struct LocationSelector: View {
    @State var showSearchSheet = false
    
    @Binding var location : Location?
    var placeholder: String
    var placeholderColor: Color = .gray
    var color: Color = .black
    
    
    var body: some View {
        Button(location?.name ?? placeholder) {
            showSearchSheet.toggle()
        }
        .foregroundStyle(location != nil
                         ? color
                         : placeholderColor)
        .sheet(isPresented: $showSearchSheet, content: {
            LocationSheet(location: $location, show: $showSearchSheet)
        })
    }
}

struct TimeSelector: View {
    
    @State var showSheet = false
    @Binding var time: Date
    var color: Color = .black
    var body: some View {
        NavigationLink(destination: TimePicker().navigationBarBackButtonHidden(true)) {
            HStack {
                Text("Time")
                Spacer()
                Text(Helpers.shared.shortLocaleFormat(time: time))
            }.foregroundStyle(color)
        }
    }
}
