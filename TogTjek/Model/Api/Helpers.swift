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
    }
}
