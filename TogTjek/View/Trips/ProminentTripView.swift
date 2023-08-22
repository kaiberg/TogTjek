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
            TimeInfo(scheduledTime: trip.origin.time, delayedTime: trip.origin.realInformation?.time ?? nil)
            
            VStack {
                HStack(alignment:.top) {
                    VStack(alignment:.leading) {
                        TypeInfo(name:trip.name, type:trip.type)
                    }.padding(.leading,3)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)
                    TimeInfo(scheduledTime: trip.destination.time, delayedTime: trip.destination.realInformation?.time ?? nil, alignment: .trailing)

                }
                
                VStack(alignment:.leading) {
                    switch trip.messageList?.message {
                    case nil:
                        InfoText(icon: "", info: "")
                    case .messageElement(let element):
                        InfoText(icon: "exclamationmark.triangle.fill", info: element.header.empty)
                    case .messageElementArray(let array):
                        ForEach(array) { element in
                            InfoText(icon: "exclamationmark.triangle.fill", info: element.header.empty)
                        }
                    }
                }
                
            }
        }
    }
    
    struct TimeInfo: View {
        var scheduledTime: Date
        var delayedTime: Date? = nil
        var alignment: HorizontalAlignment = .leading
        
        var body: some View {
            VStack(alignment: alignment) {
                Text(Helpers.shared.shortLocaleFormat(time: scheduledTime))
                if(delayedTime != nil) {
                    Text(delayText)
                        .foregroundStyle(.red)
                }

            }
        }
        
        private var delayText : String {
            if(delayedTime == nil) {
                return ""
            }
            
            
            let difference = Helpers.shared.minutesDifference(date1: scheduledTime, date2: delayedTime!)
            return difference > 0 ? "+\(difference)" : String(difference)
        }
    }
    
    struct InfoText: View {
        var icon: String
        var info: String
        
        var body: some View {
            if(icon != "" || info != "") {
                HStack(alignment: .top) {
                    Image(systemName: icon)
                    Text(info).font(.subheadline)
                }
            }
        }
    }
    

}

struct TypeInfo: View {
    var name: String
    var type: String
    var body: some View {
        Text(name).font(.caption2).foregroundStyle(.white).padding(.all, 4).background(.green).clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
    }
}

#Preview {
    return ProminentTripView(trip: SampleData.getTrip()!)
}
