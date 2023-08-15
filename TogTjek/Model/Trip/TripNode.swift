//
//  TripNode.swift
//  TogTjek
//
//  Created by kai delay on 15/08/2023.
//

import Foundation

enum TripState: String, Codable, Hashable {
    case normal
    case delayed
    case cancelled
    
}

class TripNode {
    var station : Station
    var train : Train
    
    init(station: Station, train: Train) {
        self.station = station
        self.train = train
    }
}
