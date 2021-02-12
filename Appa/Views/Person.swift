//
//  Person.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/6/21.
//

import Foundation
import SwiftUI
import Combine

class Person: ObservableObject {
    var name: String
    var pfp: UIImage = UIImage(systemName: "person")!
    @Published var placesVisited: [Place]
    var autosave: AnyCancellable?
        
    init(name: String, placesVisited: [Place]) {
        self.name = name
        let defaultsKey = "User"
        self.placesVisited = Array(fromPropertyList: UserDefaults.standard.object(forKey: defaultsKey))
        autosave = $placesVisited.sink { placesVisited in
            UserDefaults.standard.set(placesVisited.asPropertyList, forKey: defaultsKey)
        }
    }
    
    func changePfp(newPfp: UIImage) {
        pfp = newPfp
    }

    func rename(to newName: String) {
        name = newName
    }
    
    func addPlace(place: Place) {
        placesVisited.append(place)
        print("visited: \(placesVisited.count)")
    }
}

extension Array where Element == Place {
    var asPropertyList: [Data?] {
        var dataArray = [Data?]()
        for (element) in self {
            dataArray.append(element.json)
        }
        return dataArray
    }
    
    init(fromPropertyList plist: Any?) {
        self.init()
        let dataArray = plist as? [Data?] ?? []
        for data in dataArray {
            self.append(Place(json: data)!)
        }
    }
}
