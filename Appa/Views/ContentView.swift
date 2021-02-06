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
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var locationManager = LocationManager()
    @State var selection: MKAnnotation?
    
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }

    var currentLocation: CLLocationCoordinate2D? {
        locationManager.lastLocation?.coordinate
    }
    
    @State private var searchQuery: String = ""
    
    var body: some View {
        ZStack {
            MapView(currentCoordinate: currentLocation, selection: $selection)
            VStack{
                SearchBar(text: $searchQuery)
                    .frame(maxHeight: 100, alignment: .topLeading)
                Spacer()
            }
        }
    }
}
