//
//  ContentView.swift
//  VacationInVegas
//
//  Created by Mohit Gupta on 18/07/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    var place : Place
    @State var position : MapCameraPosition
    
    var body: some View {
        Map(position: $position){
            Annotation(place.intrested ? "Place of Intrest" : "Not Interested", coordinate: place.location){
                ZStack{
                    RoundedRectangle(cornerRadius: 7)
                        .fill(.ultraThickMaterial)
                        .stroke(.secondary, lineWidth : 5)
                    Image(systemName: place.intrested ? "face.smiling" : "hand.thumbsdown")
                        .padding(3)
                }.onTapGesture {
                    place.intrested.toggle()
                }
            }
        }.toolbarBackground(.automatic)
    }
}

#Preview {
    @Previewable @State var place = Place.previewPlaces[1]
    
    MapView(place: Place.previewPlaces[0], position: .camera(MapCamera(centerCoordinate: Place.previewPlaces[0].location, distance: 1000, heading: 250 , pitch: 80)))
}
