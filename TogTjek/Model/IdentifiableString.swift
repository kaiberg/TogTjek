//
//  IdentifiableString.swift
//  TogTjek
//
//  Created by kai delay on 15/08/2023.
//

import Foundation

class IdentifiableString : Identifiable, Hashable {
    static func == (lhs: IdentifiableString, rhs: IdentifiableString) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    var name : String
    init(name: String) {
        self.name = name
    }
}
