//
//  TripFinder.swift
//  TogTjek
//
//  Created by kai delay on 19/08/2023.
//

import SwiftUI

struct TripFinder: View {
    @State var from : Location?
    @State var to : Location?
    @State var trips : [TripNode] = []
    
    var body: some View {
        Form {
            Section {
                LocationSelector(location: $from, placeholder: "From")
                LocationSelector(location: $to, placeholder: "To")

                NavigationLink(destination: TripView()) {
                    HStack {
                        Text("Time")
                        Spacer()
                        Text("3:18 PM")
                    }
                }
                
            }
            
            Section {
                List {
                    ProminentTripView()
                    ProminentTripView()
                    ProminentTripView()
                    ProminentTripView()
                    ProminentTripView()
                }
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
            
            if(text == "tommerup") {
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
