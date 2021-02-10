//
//  Place.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/4/21.
//

import Foundation
import UIKit
import MapKit
import SwiftUI

class Place: NSObject, MKAnnotation, Identifiable, ObservableObject {
    var name: String
    var coordinate: CLLocationCoordinate2D
    var photos = [UIImage]()
    var journal: String = ""
    var id: UUID
    
    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.name = name
        self.id = UUID()
    }
    
    func addImage(image: UIImage) {
        photos.append(image)
        print("images: \(photos.count)")
    }
    
    func addJournal(journal: String) {
        self.journal = journal
    }
}
