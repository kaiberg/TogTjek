//
//  Trip.swift
//  TogTjek
//
//  Created by kai delay on 15/08/2023.
//

import Foundation

class Trip {
    var start : TripNode
    var stop : TripNode
    
    init(start: TripNode, stop: TripNode) {
        self.start = start
        self.stop = stop
    }
}
