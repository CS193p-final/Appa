//
//  ContentView.swift
//  Appa
//
//  Created by Duong Pham on 2/2/21.
//

import SwiftUI
import CoreData
import UIKit
import MapKit

struct ContentView: View {
    //@Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var locationService = LocationService()
    @State var selection: MKAnnotation?
    @State private var showSearchView = false
    @State private var showMenu = false
    
    @State private var landmarks = [Landmark]()
    @State private var searchString = ""
    @State private var tapped = false

    var currentLocation: CLLocationCoordinate2D? {
        locationManager.lastLocation?.coordinate
    }
    
    var body: some View {
        MapView(landmarks: landmarks, currentCoordinate: currentLocation, selection: $selection)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                SearchBarAndMenuView(searchString: $searchString, action: getNearbyLandmarks),
                alignment: .topLeading
            )
    }
    
    private func getNearbyLandmarks() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchString
        request.region = MKCoordinateRegion(center: currentLocation!, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map { Landmark(placemark: $0.placemark) }
            }
        }
    }
}

struct ContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewLayout(.sizeThatFits)
        }
    }
}
