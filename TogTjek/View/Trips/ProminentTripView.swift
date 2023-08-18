//
//  ProminentTripView.swift
//  TogTjek
//
//  Created by kai delay on 17/08/2023.
//

import SwiftUI

struct ProminentTripView: View {
    var body: some View {
        HStack(alignment:.top) {
            TimeInfo(scheduledTime: "19:59", delayedTime: "5")
            
            VStack {
                HStack(alignment:.top) {
                    VStack(alignment:.leading) {
                        Text("")
                            .frame(height: 50)
                        Text("Departure Bus 151: ")
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)
                    
                    TimeInfo(scheduledTime: "19:59", delayedTime: "5", alignment: .trailing)
                }
                
                VStack(alignment:.leading) {
                    InfoText(icon: "exclamationmark.triangle.fill", info: "Assens: Rute 130 - 132 - 151 - 152 - 820U - 825U")
                    InfoText(icon: "exclamationmark.triangle.fill", info: "Bellinge Brogaarrdsvej ensrettes")
                    InfoText(icon: "info.square", info: "Note: Plustur is flextrafik and you have to book it at least 2 hours before departure by activating \"Price & buy\". Displayed travel times for flextrafik are indicative. Get more information here")
                    
                }
            }
            
        }
        .padding()
    }
}

struct TimeInfo: View {
    var scheduledTime: String
    var delayedTime: String? = nil
    var alignment: HorizontalAlignment = .leading
    
    var body: some View {
        VStack(alignment: alignment) {
            Text(scheduledTime)
            Text(delayText)
                .foregroundStyle(.red)
        }
    }
    
    private var delayText : String {
        get { "\(delayedTime != nil ? "+" : "")\(delayedTime ?? "")"}
    }
}

struct InfoText: View {
    var icon: String
    var info: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: icon)
            Text(info)
        }
        .padding(.top)
    }
}

#Preview {
    ProminentTripView()
}
