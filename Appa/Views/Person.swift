//
//  Person.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/6/21.
//

import Foundation
import SwiftUI

struct Person {
    var firstName: String
    var lastName: String
    var pfp: UIImage = UIImage(systemName: "person")!
    var placesVisited = [Place]()
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    mutating func changePfp(newPfp: UIImage) {
        pfp = newPfp
    }
    
    mutating func renameFirstname(to newName: String) {
        firstName = newName
    }
    
    mutating func renameLastname(to newName: String) {
        lastName = newName
    }
    
    mutating func addPlace(place: Place) {
        placesVisited.append(place)
    }
}
