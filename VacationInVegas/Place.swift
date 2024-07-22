//
//  Place.swift
//  VacationInVegas
//
//  Created by Mohit Gupta on 20/07/24.
//
import SwiftData
import SwiftUI
import MapKit

@Model
class Place {
    #Unique<Place>([\.name, \.latitude, \.longitude])
    @Attribute(.unique) var name : String
    var latitude : Double
    var longitude : Double
    var intrested : Bool
    var location : CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var image : Image {
        Image(name.lowercased().replacingOccurrences(of: " ", with: ""))
    }
    
    init(name: String, latitude: Double, longitude: Double, intrested: Bool) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.intrested = intrested
    }
    
    // Data is stored in only current running memory
    @MainActor
    static var preview : ModelContainer{
        let container = try! ModelContainer(for: Place.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

        for place in previewPlaces{
            container.mainContext.insert(place)
        }
        
        return container
    }
    
    static var previewPlaces  : [Place]{
        [
            Place(name: "Bellagio", latitude: 36.112, longitude: -115.1765, intrested: true),
            Place(name: "Paris", latitude: 37.112, longitude: -115.1765, intrested: true),
            Place(name: "Treasure Island", latitude: 38.112, longitude: -115.1765, intrested: true),
            Place(name: "Stratosphere", latitude: 39.112, longitude: -115.1765, intrested: true),
            Place(name: "Luxor", latitude: 40.112, longitude: -115.1765, intrested: false),
            Place(name: "Excalibur", latitude: 41.112, longitude: -115.1765, intrested: true)
        ]
    }
}
