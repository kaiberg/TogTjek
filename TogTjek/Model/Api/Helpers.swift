//
//  Helpers.swift
//  TogTjek
//
//  Created by kai delay on 19/08/2023.
//

import Foundation

class Helpers {
    static let shared = Helpers()
    private let dateFormatter = DateFormatter()
    private let timeFormatter = DateFormatter()
    private let shortFormatter = DateFormatter()
    private let getDateFormatter = DateFormatter()
    
    func minutesDifference(date1 : Date, date2 : Date) -> Int {
        let seconds = date2.timeIntervalSince(date2)
        return Int(seconds / 60)
    }
    
    func removeNewLines(value: String) -> String {
        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getDate(date: String, time: String) -> Date? {
       if let date = getDateFormatter.date(from: "\(date) \(time)") {
            return date
        } else {
            return nil;
        }
    }
    
    func formatDate(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func formatTime(time : Date) -> String {
        return timeFormatter.string(from: time)
    }
    
    func shortLocaleFormat(time: Date) -> String {
        return shortFormatter.string(from: time)
    }
    
    init() {
        dateFormatter.dateFormat = "dd.MM.yy"
        timeFormatter.dateFormat = "HH:mm"
        shortFormatter.timeStyle = .short
        shortFormatter.dateStyle = .none
        getDateFormatter.dateFormat = "dd.MM.yy HH:mm"
    }
}
