//
//  MemoryView.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/6/21.
//

import SwiftUI
import UIKit
import MapKit

struct MemoryView: View {
    @State var user: Person

    var body: some View {
        VStack {
            Text("Places you have visited").font(.headline)
            Button {
                user.addPlace(place: Place(name: "Hanoi", coordinate: CLLocationCoordinate2D(latitude: 21.0278, longitude: 105.8342)))
            } label: {
                Text("Add place")
            }
            List {
                VStack {
                    ForEach(user.placesVisited) { place in
                        PlaceView(place: $user.placesVisited[user.placesVisited.firstIndex(matching: place)!])
                    }
                }
            }
        }
    }
    
    var photoHeight: CGFloat {
        CGFloat((user.placesVisited.count - 1) / 6) * 70 + 70
    }
}


//struct MemoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemoryView()
//    }
//}
