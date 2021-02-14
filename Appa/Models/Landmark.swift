//
//  Landmark.swift
//  Appa
//
//  Created by Duong Pham on 2/11/21.
//

import UIKit
import MapKit

struct Landmark {
    let placemark: MKPlacemark
    
    var id: UUID {
        UUID()
    }
    
    var name: String {
        placemark.name ?? ""
    }
    
    var title: String {
        placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        placemark.coordinate
    }
}
