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
    var user = Person(name: "last first", placesVisited: [Place]())
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
                        destination: ProfileView().environmentObject(user),
                        label: {
                            Text("Profile")
                        })
                    NavigationLink(
                        destination: AchievementView().environmentObject(user),
                        label: {
                            Text("Achievement")
                        })
                    NavigationLink(
                        destination: MemoryView(user: user),
                        label: {
                            Text("Memory")
                        })
                    NavigationLink(
                        destination: SettingsView(),
                        label: {
                            Text("Settings")
                        }
                    )                }
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
