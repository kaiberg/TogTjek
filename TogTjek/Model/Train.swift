//
//  Train.swift
//  TogTjek
//
//  Created by kai delay on 15/08/2023.
//

import Foundation

enum TrainState : String, Codable, Hashable {
    case normal
    case relocated
}

class Train {
    var arrival: Date
    var track: Int
    var state: TrainState
    
    init(arrival: Date, track: Int, state: TrainState) {
        self.arrival = arrival
        self.track = track
        self.state = state
    }
}
