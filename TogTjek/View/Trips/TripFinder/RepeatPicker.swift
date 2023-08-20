//
//  RepeatPicker.swift
//  TogTjek
//
//  Created by kai delay on 19/08/2023.
//

import SwiftUI

struct day : Identifiable {
    var id = UUID()
    var title : String
    var enabled : Bool = false
    
    init(title: String, enabled: Bool) {
        self.title = title
        self.enabled = enabled
    }
}

struct RepeatPicker: View {
    @Environment(\.dismiss) var dismiss
    @Binding var days : [day]
    
    var body: some View {
        Form {
            List {
                ForEach($days) { day in
                    DayView(day: day)
                }
            }

        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("cancel") {}
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("save") {
                    dismiss.callAsFunction()
                }.disabled(days.allSatisfy { !$0.enabled })
            }
        }
    }
}

//#Preview {
//    RepeatPicker()
//}

struct DayView: View {
    @Binding var day : day
    
    var body: some View {
        Button {
            day.enabled.toggle()
        } label: {
            HStack {
                Text("Every \(day.title)")
                    .foregroundStyle(.black)
                Spacer()
                if(day.enabled) {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
