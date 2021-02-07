//
//  Place.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/4/21.
//

import Foundation
import UIKit
import MapKit

class Place: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
