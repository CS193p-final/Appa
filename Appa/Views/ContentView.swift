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
    @State var selection: MKAnnotation?
    @State private var showSearchBar = false
    @State private var showMenu = false
    
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }

    var currentLocation: CLLocationCoordinate2D? {
        locationManager.lastLocation?.coordinate
    }
    
    
    var body: some View {
        HStack {
            menuIcon
            ZStack {
                MapView(currentCoordinate: currentLocation, selection: $selection)
                SearchBar()
            }
        }
    }
    
    private var menuIcon: some View {
        Image(systemName: "menubar.rectangle")
            .imageScale(.large)
            .onTapGesture {
                showMenu = true
            }
            .sheet(isPresented: $showMenu, content: {
                MenuView()
            })
    }
}

struct ContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewLayout(.sizeThatFits)
            ContentView()
        }
    }
}
