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
        if !showSearchView {
            MapView(currentCoordinate: currentLocation, selection: $selection)
                .edgesIgnoringSafeArea(.all)
                .overlay( SearchBarAndMenuView(), alignment: .topLeading)
        }
        else {
            searchView
        }
    }
    
    var searchView: some View {
        VStack {
            Form {
                Section(header: Text("Location Search")) {
                    ZStack(alignment: .trailing) {
                        TextField("Search", text: $locationService.queryFragment)
                        if locationService.status == .isSearching {
                            Image(systemName: "clock")
                                .foregroundColor(.gray)
                        }
                    }
                }
                Section(header: Text("Results")) {
                    List {
                        Group {
                            switch locationService.status {
                            case .noResult: Text("No result")
                            case .error(let errMsg): Text("Error: \(errMsg)")
                            default: EmptyView()
                            }
                        }
                        .foregroundColor(.gray)
                        
                        ForEach(locationService.searchResults, id: \.self) { completionResult in
                            Text(completionResult.title)
                        }
                    }
                }
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
        }
    }
}
