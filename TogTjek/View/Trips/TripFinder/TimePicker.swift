//
//  TimePicker.swift
//  TogTjek
//
//  Created by kai delay on 19/08/2023.
//

import SwiftUI

struct TimePicker: View {
    @Environment(\.dismiss) var dismiss
    @State var selection = 1
    
    @State var days = [
        day(title: "Monday", enabled: false),
        day(title: "Tuesday", enabled: false),
        day(title: "Wednesday", enabled: false),
        day(title: "Thursday", enabled: false),
        day(title: "Friday", enabled: false),
        day(title: "Saturday", enabled: false),
        day(title: "Sunday", enabled: false),
    ]
    
    @State var selectedDate = Date()
    
    var body: some View {
        Form {
            VStack {
                Picker(selection: $selection, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                    Text("Depart").tag(1)
                    Text("Arrive by").tag(2)
                }.pickerStyle(.segmented)
                
                DatePicker("Time", selection: $selectedDate, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(.wheel)
            }
            
            NavigationLink(destination: RepeatPicker(days: $days)) {
                HStack {
                    Text("Repeat")
                    Spacer()
                    Text(formatSelectedDates())
                }
            }
        }.toolbar {
            ToolbarItem(placement:.topBarLeading) {
                Button("cancel", role: .cancel) {
                    dismiss.callAsFunction()
                }
            }
            
            ToolbarItem {
                Button("save") {
                    dismiss.callAsFunction()
                }.disabled(formNotFilled())
            }
        }
    }
    
    func formNotFilled() -> Bool {
        return days.allSatisfy { !$0.enabled }
    }
    
    func formatSelectedDates() -> String {
        let weekdaysEnabled = days[0...4].allSatisfy { $0.enabled }
        let weekendEnabled = days[0...4].allSatisfy { $0.enabled }

        if weekdaysEnabled && weekendEnabled {
            return "Every day"
        }
        
        else if !weekdaysEnabled && !weekendEnabled {
            return "Never"
        }
        
        else if !weekdaysEnabled && weekendEnabled {
            return "Weekends"
        }
        
        else if weekdaysEnabled && !weekendEnabled {
            return "Weekdays"
        }
        
        else {
            let enabledDays = days.filter { $0.enabled }
            let concatenatedString = enabledDays.map { String($0.title.prefix(3)) }
                .joined(separator: " ")
            return concatenatedString
        }
    }
}

#Preview {
    TimePicker()
}
