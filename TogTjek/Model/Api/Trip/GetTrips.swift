//
//  GetTrips.swift
//  TogTjek
//
//  Created by kai delay on 19/08/2023.
//

import Foundation

// / trip?time=20:46&useBus=0&originId=008600512&destCoordX=12565562&destCoordName=København H&viaId=008600626&destCoordY=55673063&date=18.08.23&format=json

class GetTrips {
    static func getTrips(origin: Location, destination: Location, date : Date) async -> [TripJ] {
        let useBus = 0
        let originId = origin.id
        let destCoordX = destination.x
        let destCoordY = destination.y
        let destCoordName = destination.name
        let viaId = destination.id
        let time = Helpers.shared.formatTime(time: date)
        let date = Helpers.shared.formatDate(date: date)
        
        
        let route = "trip?time=\(time)&useBus=\(useBus)&originId=\(originId)&destCoordX=\(destCoordX)&destCoordY=\(destCoordY)&destCoordName=\(destCoordName)&viaId=\(viaId)&date=\(date)&format=json"
        if(API_BASE_URL == nil) { return [] }
        let urlString = "\(API_BASE_URL ?? "")/\(route)"
        print(API_BASE_URL)
        print("heres the URL: \(urlString)")
        let url = URL(string: urlString)!
        let (data, response) = try! await URLSession.shared.data(from: url)
        
        if var inputString = String(data: data, encoding: .utf8) {
            inputString = inputString.replacingOccurrences(of: "\n", with: "")
            
            if let modifiedData = inputString.data(using: .utf8) {
                let decoder = JSONDecoder();
                let decoded = try? decoder.decode(TripsJSON.self, from: modifiedData)
                
                print("heres the decoded: \(decoded)")
                
                return decoded?.tripList.trip ?? []
                
            }
            
            
        }
        return []

    }
}

class TripsJSON : Decodable {
    var tripList : TripList
    
    enum CodingKeys: String, CodingKey {
        case tripList = "TripList"
    }
}

class TripList: Decodable {
    var noNamespaceSchemaLocation: String
    var trip: [TripJ]

    enum CodingKeys: String, CodingKey {
        case noNamespaceSchemaLocation
        case trip = "Trip"
    }
}

class TripJ: Decodable, Identifiable {
    var leg: [Leg]

    enum CodingKeys: String, CodingKey {
        case leg = "Leg"
    }
}

class Leg: Decodable, Identifiable {
    var name, type: String
    var origin, destination: Destination
        var notes: Notes
        var journeyDetailRef: JourneyDetailRef?
        var messageList: MessageList?

    enum CodingKeys: String, CodingKey {
        case name, type
        case origin = "Origin"
        case destination = "Destination"
        case notes = "Notes"
        case journeyDetailRef = "JourneyDetailRef"
        case messageList = "MessageList"
    }
}

class Destination: Decodable {
    private var _time: String
    private var _date: String
    private var _rtTime: String?
    private var _rtDate: String?
    private var _rtTrack: String?
    
    var name: String
    var type: String
    var routeIdx: String?
    var time: Date
    var realInformation: RealTimeInformation?
    var track: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case routeIdx
        case time
        case date
        case track
        case _rtTime = "rtTime"
        case _rtDate = "rtDate"
        case _rtTrack = "rtTrack"

    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(String.self, forKey: .type)
        self.routeIdx = try container.decodeIfPresent(String.self, forKey: .routeIdx)
        self._time = try container.decode(String.self, forKey: .time)
        self._date = try container.decode(String.self, forKey: .date)
        self.track = try container.decodeIfPresent(String.self, forKey: .track)
        self.time = Helpers.shared.getDate(date: _date, time: _time)!
        self._rtDate = try container.decodeIfPresent(String.self, forKey: ._rtDate)
        self._rtTime = try container.decodeIfPresent(String.self, forKey: ._rtTime)
        self._rtTrack = try container.decodeIfPresent(String.self, forKey: ._rtTrack)
        
        if(_rtDate != nil && _rtTime != nil && _rtTrack != nil) {
            let realTime = Helpers.shared.getDate(date: _rtDate!, time: _rtTime!)!
            self.realInformation = RealTimeInformation(time: realTime, track: _rtTrack!)
        }
    }
}

class RealTimeInformation {
    var time: Date
    var track: String
    
    init(time: Date, track: String) {
        self.time = time
        self.track = track
    }
}

class JourneyDetailRef: Decodable {
    var ref: String
}

class MessageList: Decodable {
    var message: MessageUnion

    enum CodingKeys: String, CodingKey {
        case message = "Message"
    }
}

enum MessageUnion: Decodable {
    case messageElement(MessageElement)
    case messageElementArray([MessageElement])

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode([MessageElement].self) {
                self = .messageElementArray(x)
                return
            }
            let messageElement = try container.decode(MessageElement.self)
            self = .messageElement(messageElement)
        } catch {
            throw DecodingError.typeMismatch(MessageUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MessageUnion", underlyingError: error))
        }
    }
}

class MessageElement: Decodable, Identifiable {
    var header, text: Header
    var links: Links

    enum CodingKeys: String, CodingKey {
        case header = "Header"
        case text = "Text"
        case links = "Links"
    }
}

class Header: Decodable {
    var empty: String

    enum CodingKeys: String, CodingKey {
        case empty = "$"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.empty = Helpers.shared.removeNewLines(value: try container.decode(String.self, forKey: .empty))
    }

}

class Links: Decodable {
    var link: Link
    
    enum CodingKeys: String, CodingKey {
        case link = "Link"
    }
}

class Link: Decodable {
    var url: String
    var text: String
}

class Notes: Decodable {
    var text: String
}
