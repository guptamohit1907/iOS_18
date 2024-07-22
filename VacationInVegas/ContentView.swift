//
//  ContentView.swift
//  VacationInVegas
//
//  Created by Mohit Gupta on 18/07/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Places", systemImage: "photo"){
                PlaceList()
            }
            
            Tab("Trip History", systemImage: "chart.line.uptrend.xyaxis"){
                TripsChart()
            }
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
        .modelContainer(Place.preview)
}
