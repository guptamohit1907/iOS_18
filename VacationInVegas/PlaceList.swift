//
//  ContentView.swift
//  VacationInVegas
//
//  Created by Mohit Gupta on 18/07/24.
//

import SwiftUI
import SwiftData
import MapKit

struct PlaceList: View {
    @Query(sort : \Place.name) private var places : [Place]
    
    @State private var showImages = false
    @State private var searchText = ""
    @State private var filterByIntrested = false
    @Namespace var nameSpace
    
    private var predicate : Predicate<Place> {
        #Predicate<Place>{
            if !searchText.isEmpty && filterByIntrested{
                $0.name.localizedStandardContains(searchText) && $0.intrested
            } else if !searchText.isEmpty {
                $0.name.localizedStandardContains(searchText)
            } else if filterByIntrested {
                $0.intrested
            } else {
                true
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            List((try? places.filter(predicate)) ?? places) { place in
                NavigationLink(value : place){
                    HStack{
                        place.image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 7))
                            .frame(width: 100, height: 100)
                        Text(place.name)
                        
                        Spacer()
                        
                        if place.intrested{
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                                .padding(.trailing)
                        }
                    }
                }.matchedTransitionSource(id: 1, in: nameSpace)
                .swipeActions(edge : .leading){
                    Button(place.intrested  ? "Interested" : "Not Interested", systemImage : "star"){
                        place.intrested.toggle()
                    }
                    .tint(place.intrested ? .yellow : .gray)
                 }
            }
            .navigationTitle("Places")
            .searchable(text: $searchText, prompt : "Find a place")
            .animation(.default, value : searchText)
            .navigationDestination(for: Place.self){ place in
                MapView(place: place, position:  .camera(MapCamera(centerCoordinate: place.location, distance: 1000, heading: 250 , pitch: 80)))
            }.navigationTransition(.zoom(sourceID : 1, in : nameSpace))
            
            .toolbar {
                ToolbarItem(placement : .topBarTrailing){
                    Button("Show Images", systemImage: "photo"){
                        showImages.toggle()
                    }
                }
                ToolbarItem(placement : .topBarLeading){
                    Button("Filter", systemImage: filterByIntrested ? "star.fill" : "star"){
                        withAnimation {
                            filterByIntrested.toggle()
                        }
                    }.tint(filterByIntrested ? .yellow : .blue)
                }
            }.sheet(isPresented: $showImages) {
                Scrolling()
            }
        }
    }
}

#Preview {
    PlaceList()
        .modelContainer(Place.preview)
}
