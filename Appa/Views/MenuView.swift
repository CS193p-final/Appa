//
//  MenuView.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/6/21.
//

import SwiftUI
import MapKit
import UIKit

struct MenuView: View {
    var user = Person(firstName: "First", lastName: "Last")
    @ObservedObject var locationManager = LocationManager()
    var currentLocation: CLLocationCoordinate2D? {
        locationManager.lastLocation?.coordinate
    }
    @State var selection: MKAnnotation?

    var body: some View {
        VStack {
            NavigationView {
                List(){
                    NavigationLink(
                        destination: ProfileView(user: user),
                        label: {
                            Text("Profile")
                        })
                    NavigationLink(
                        destination: AchievementView(),
                        label: {
                            Text("Achievement")
                        })
                    NavigationLink(
                        destination: MemoryView(placeVisited: user.placesVisited),
                        label: {
                            Text("Memory")
                        })
                    NavigationLink(
                        destination: SettingsView(),
                        label: {
                            Text("Settings")
                        })
                    NavigationLink(
                        destination: MapView(currentCoordinate: currentLocation, selection: $selection)
                            .edgesIgnoringSafeArea(.all)
                            .overlay(SearchView(), alignment: .topLeading),
                        label: {
                            Text("Map")
                        })


                }
                .navigationTitle(Text("Menu"))
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
