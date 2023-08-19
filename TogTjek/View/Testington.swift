//
//  Testington.swift
//  TogTjek
//
//  Created by kai delay on 15/08/2023.
//

import SwiftUI

struct Testington: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello World")
            
            Button("click me") {
                if let apiUrl = Bundle.main.infoDictionary?["API_BASE_URL"] as? String {
                    
                    print(apiUrl)
                }
            }
            
            Button("test api Search") {
                Task {
                    let data = await GetLocation.getLocations(searchString: "Tommerup")
                    print("heres the data \(data)")
                }

            }
        }
        .padding()
    }
}

#Preview {
    Testington()
}
