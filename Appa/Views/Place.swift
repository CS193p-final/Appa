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

typealias CLLocationDegrees = Double
class Place: NSObject, MKAnnotation, Identifiable, Codable {
    var name: String
    var coordinate: CLLocationCoordinate2D
    var photos = [Data]()
    var journal: String = ""
    var id: UUID
    
    var json: Data? {
        try? JSONEncoder().encode(self)
    }
    
    convenience init?(json: Data?) {
        if json != nil, let newPlace = try? JSONDecoder().decode(Place.self, from: json!) {
            self.init(name: newPlace.name, coordinate: newPlace.coordinate)
        } else {
            return nil
        }
    }
    
    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.name = name
        self.id = UUID()
    }
    
    func addImage(image: UIImage) {
        let imageData = image.pngData()
        photos.append(imageData!)
        print("images: \(photos.count)")
    }
    
    func addJournal(journal: String) {
        self.journal = journal
    }
}

extension CLLocationCoordinate2D: Codable {
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
}

