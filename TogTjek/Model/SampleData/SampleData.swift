//
//  SampleData.swift
//  TogTjek
//
//  Created by kai delay on 17/08/2023.
//

import Foundation

struct SampleData {
    static var departureTrips: [IdentifiableString] = [
        IdentifiableString(name: "Odense"),
        IdentifiableString(name: "Tommerup")
    ]
    
    static var homeTrips: [IdentifiableString] = [
        IdentifiableString(name: "Odense"),
        IdentifiableString(name: "Tommerup")
    ]
    
    static func getTrip() -> Leg? {
        guard let jsonData = SampleJson.aJson.replacingOccurrences(of: "\n", with: "").data(using: .utf8) else {
            return nil
        }
        
        do {
            let decodedLeg = try JSONDecoder().decode(Leg.self, from: jsonData)
            return decodedLeg
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}

struct SampleJson {
    static var aJson: String =
"""
{
  "name": "Re 4781",
  "type": "REG",
  "Origin": {
    "name": "Odense St.",
    "type": "ST",
    "routeIdx": "0",
    "time": "22:45",
    "date": "21.08.23",
    "track": "6",
    "rtTrack": "6"
  },
  "Destination": {
    "name": "Tommerup St.",
    "type": "ST",
    "routeIdx": "2",
    "time": "22:54",
    "date": "21.08.23",
    "track": "3",
    "rtTrack": "3"
  },
  "Notes": {
    "text": "Retning: Fredericia St.;Cykelreservering kræves"
  },
  "JourneyDetailRef": {
    "ref": "http://webapp.rejseplanen.dk/bin//rest.exe/journeyDetail?ref=765405%2F257091%2F189428%2F160421%2F86%3Fdate%3D21.08.23%26station_evaId%3D8600512%26format%3Djson"
  },
  "MessageList": {
    "Message": {
      "Header": {
        "$": "\nElevatoren på Odense Banegård ved Byens Bro til spor 3/4 er i øjeblikket ude af drift\n"
      },
      "Text": {
        "$": "\n-\n"
      },
      "Links": {
        "Link": {
          "url": "https://www.dsb.dk/find-produkter-og-services/handicapservice-i-dsb/",
          "text": "Læs om Handicapservice"
        }
      }
    }
  }
}
"""
    
    static var Legjson: String  =
"""
{
  "name": "Re 2776",
  "type": "REG",
  "Origin": {
    "name": "Tommerup St.",
    "type": "ST",
    "routeIdx": "9",
    "time": "23:11",
    "date": "21.08.23",
    "track": "1",
    "rtTrack": "1"
  },
  "Destination": {
    "name": "Odense St.",
    "type": "ST",
    "routeIdx": "11",
    "time": "23:23",
    "date": "21.08.23",
    "track": "3",
    "rtTrack": "3"
  },
  "Notes": {
    "text": "Retning: Odense St.;Cykelreservering kræves"
  },
  "JourneyDetailRef": {
    "ref": "http://webapp.rejseplanen.dk/bin//rest.exe/journeyDetail?ref=315000%2F107965%2F326432%2F58216%2F86%3Fdate%3D21.08.23%26station_evaId%3D8600509%26format%3Djson"
  },
  "MessageList": {
    "Message": {
      "Header": {
        "$": "Elevatoren på Odense Banegård ved Byens Bro til spor 3/4 er i øjeblikket ude af drift"
      },
      "Text": {
        "$": "-"
      },
      "Links": {
        "Link": {
          "url": "https://www.dsb.dk/find-produkter-og-services/handicapservice-i-dsb/",
          "text": "Læs om Handicapservice"
        }
      }
    }
  }
}
"""}
