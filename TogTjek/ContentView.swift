//
//  ContentView.swift
//  TogTjek
//
//  Created by kai delay on 15/08/2023.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        TabView {
            TripsWrapper()
            
            Testing()
                .tabItem {
                    Label("Testing", systemImage: "testtube.2")
                }
            
            Settings()
                .tabItem { Label("Settings", systemImage: "gear") }
        }.onAppear {
            print(SampleData.getTrip())
        }
    }
    
}

#Preview {
    ContentView()
}
