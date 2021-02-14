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
        ZStack(alignment: .top) {
            MapView(landmarks: landmarks, currentCoordinate: currentLocation, selection: $selection)
            HStack {
                menuIcon
                TextField("Search", text: $searchString, onCommit:  {
                    getNearbyLandmarks()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .offset(y: 44)
            }
            
            PlaceListView(landmarks: landmarks) {
                self.tapped.toggle()
            }
            .animation(.spring())
            .offset(y: calculateOffset())
        }
    }
    
    private var menuIcon: some View {
        Button {
            showMenu = true
        } label: {
            Image(systemName: "menubar.rectangle")
                .imageScale(.large)
        }
        .sheet(isPresented: $showMenu, content: {
            MenuView()
        })

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
    
    func calculateOffset() -> CGFloat {
        if landmarks.count > 0 && !tapped {
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 4
        }
        else if self.tapped {
            return 100
        }
        else {
            return UIScreen.main.bounds.size.height
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









//var body: some View {
//    if !showSearchView {
//        MapView(currentCoordinate: currentLocation, selection: $selection)
//            .edgesIgnoringSafeArea(.all)
//            .overlay(
//                HStack {
//                    menuIcon.padding(.leading)
//                    SearchView()
//                        .onTapGesture {
//                            showSearchView = true
//                        }
//                }, alignment: .topLeading)
//    }
//    else {
//        searchView
//    }
//}


//var searchView: some View {
//    VStack {
//        Form {
//            Section(header: Text("Location Search")) {
//                ZStack(alignment: .trailing) {
//                    TextField("Search", text: $locationService.queryFragment)
//                    if locationService.status == .isSearching {
//                        Image(systemName: "clock")
//                            .foregroundColor(.gray)
//                    }
//                }
//            }
//            Section(header: Text("Results")) {
//                List {
//                    Group {
//                        switch locationService.status {
//                        case .noResult: Text("No result")
//                        case .error(let errMsg): Text("Error: \(errMsg)")
//                        default: EmptyView()
//                        }
//                    }
//                    .foregroundColor(.gray)
//
//                    ForEach(locationService.searchResults, id: \.self) { completionResult in
//                        Text(completionResult.title)
//                    }
//                }
//            }
//        }
//    }
//}
