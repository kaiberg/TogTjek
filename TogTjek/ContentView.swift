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
            Trips()
                .tabItem {
                    Label("Trips", systemImage: "airplane")
                }
            Testington()
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
