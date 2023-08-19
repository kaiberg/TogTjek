//
//  GetLocations.swift
//  TogTjek
//
//  Created by kai delay on 19/08/2023.
//

import Foundation

class GetLocation {
     static func getLocations(searchString : String) async -> [Location] {
        let route = "location?input=\(searchString)&format=json"
        if(API_BASE_URL == nil) { return [] }
        let urlString = "\(API_BASE_URL ?? "")/\(route)"
        print(API_BASE_URL)
        print("heres the URL: \(urlString)")
        let url = URL(string: urlString)!
        let (data, response) = try! await URLSession.shared.data(from: url)
        let decoded = try? JSONDecoder().decode(LocationsJSON.self, from: data)
        
        print("heres the decoded: \(decoded)")
         
        return decoded?.locationList.stopLocation ?? []
    }
}

class LocationsJSON : Decodable {
    let locationList : LocationList
    
    enum CodingKeys: String, CodingKey {
        case locationList = "LocationList"
    }
}

class LocationList : Decodable {
    let noNamespaceSchemaLocation : String
    let stopLocation : [Location]
    let coordLocation : [CoordLocation]

    enum CodingKeys: String, CodingKey {
        case noNamespaceSchemaLocation
        case stopLocation = "StopLocation"
        case coordLocation = "CoordLocation"
    }
}

class Location : Decodable {
    let name: String
    let x: String
    let y: String
    let id: String
}

class CoordLocation : Decodable {
    let name: String
    let x: String
    let y: String
    let type: String
}
