//
//  TripsWrapper.swift
//  TogTjek
//
//  Created by kai delay on 20/08/2023.
//

import SwiftUI

struct TripsWrapper: View {
    @State var showSheet = false
    @State var hasAtleastOneTripAdded = false

    var body: some View {
        NavigationStack {
            Trips()
                .refreshable {
                }
                .toolbar {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .phaseAnimator([false,true]) { content, phase in
                                if(!hasAtleastOneTripAdded) {
                                    content
                                        .hoverEffect(phase ? .automatic : .highlight)
                                        .scaleEffect(phase ? 1 : 1.05)
                                }
                            }
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
    }
}

#Preview {
    TripsWrapper()
}
