//
//  UpcomingTrip.swift
//  TogTjek
//
//  Created by kai delay on 18/08/2023.
//

import SwiftUI

struct UpcomingList: View {
    var body: some View {
        Section {
//            ForEach(0..<3) { i in
//                NavigationLink {
//                    ProminentTripView()
//
//                } label: {
//                    UpcomingTrip()
//                }
//                .listRowBackground(i == 0 ? Color.red : Color.green)
//            }
        }
    header: {
        Text("Upcoming")
    }
    }
}

struct UpcomingTrip: View {
    var body: some View {
            VStack {
                HStack {
                    Text("Odense")
                    Spacer()
                    Text("Tommerup")
                }
                
                HStack {
                    Text("19:59")
                    Spacer()
                    Text("20:23")
                }
                HStack {
                    Text("+1").foregroundStyle(.red)
                    Spacer()
                    Text("+5").foregroundStyle(.red)
                }
            }

    }
}

#Preview {
    UpcomingTrip()
}
