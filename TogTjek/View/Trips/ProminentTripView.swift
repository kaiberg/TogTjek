//
//  ProminentTripView.swift
//  TogTjek
//
//  Created by kai delay on 17/08/2023.
//

import SwiftUI

struct ProminentTripView: View {
    var trip : Leg
    
    var body: some View {
        HStack(alignment:.top) {
            TimeInfo(scheduledTime: trip.origin.time, delayedTime: "5")
            
            VStack {
                HStack(alignment:.top) {
                    VStack(alignment:.leading) {
                        Text("")
                            .frame(height: 50)
                        Text(trip.notes.text)
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)
                    
                    TimeInfo(scheduledTime: trip.destination.time, delayedTime: "5", alignment: .trailing)
                }
                
                VStack(alignment:.leading) {
                    switch trip.messageList?.message {
                        case .messageElement(let element):
                            InfoText(icon: "exclamationmark.triangle.fill", info: element.text.empty)
                    case .messageElementArray(let array):
                        ForEach(array) { element in
                            InfoText(icon: "exclamationmark.triangle.fill", info: element.text.empty)
                        }
                    default:
                        InfoText(icon: "exclamationmark.triangle.fill", info: "I SHOULDNT BE HERE")
                    }
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

//#Preview {
//    ProminentTripView()
//}
