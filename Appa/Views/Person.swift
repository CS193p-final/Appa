//
//  Person.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/6/21.
//

import Foundation
import SwiftUI

class Person: ObservableObject {
    var firstName: String
    var lastName: String
    var pfp: UIImage = UIImage(systemName: "person")!
    var placesVisited = [Place]()
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func changePfp(newPfp: UIImage) {
        pfp = newPfp
    }
    
    func renameFirstname(to newName: String) {
        firstName = newName
    }
    
    func renameLastname(to newName: String) {
        lastName = newName
    }
    
    func addPlace(place: Place) {
        placesVisited.append(place)
        print("visited: \(placesVisited.count)")
    }
}
