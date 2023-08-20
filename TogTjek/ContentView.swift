//
//  ContentView.swift
//  TogTjek
//
//  Created by kai delay on 15/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State var showSheet = false
    
    var body: some View {
        TabView {
            NavigationStack {
                Trips()
                    .toolbar {
                        Button {
                            showSheet.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }.sheet(isPresented: $showSheet, content: {
                            TripFinder()
                        })
                    }
                    .navigationTitle("Trips")
                    .navigationDestination(for: IdentifiableString.self) { string in
                        TripDetail(trip: string)
                    }
            }                .tabItem {
                Label("Trips", systemImage: "airplane")
            }
            
            Testing()
                .tabItem {
                    Label("Testing", systemImage: "testtube.2")
                }
            
            Settings()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
    
}

#Preview {
    ContentView()
}
