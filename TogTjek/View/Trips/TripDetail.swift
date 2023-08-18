//
//  TripDetail.swift
//  TogTjek
//
//  Created by kai delay on 17/08/2023.
//

import SwiftUI

struct TripDetail: View {
    var trip: IdentifiableString
    var body: some View {
        VStack {
            TabView {
                ForEach([trip, trip, trip]) { trip in
                    Text(trip.name)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: 250)
        .background(Color.red)
    }

}

#Preview {
    TripDetail(trip: IdentifiableString(name: "teste"))
}
