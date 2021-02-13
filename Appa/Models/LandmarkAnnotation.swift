//
//  LandmarkAnnotation.swift
//  Appa
//
//  Created by Duong Pham on 2/11/21.
//

import MapKit
import UIKit

class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(landmark: Landmark) {
        title = landmark.title
        coordinate = landmark.coordinate
    }
}
