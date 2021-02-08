//
//  LocationSearch.swift
//  Appa
//
//  Created by Duong Pham on 2/7/21.
//

import UIKit
import SwiftUI

struct LocationSearch: UIViewControllerRepresentable {
    typealias UIViewControllerType = Wrapper
    
    func makeCoordinator() -> Coordinator {
        Coordinator(representable: self)
    }
    
    func makeUIViewController(context: Context) -> Wrapper {
        Wrapper()
    }
    
    func updateUIViewController(_ wrapper: Wrapper, context: Context) {
        wrapper.searchController = context.coordinator.searchController
    }
 
    class Coordinator: NSObject {
        let representable: LocationSearch
        let searchController: UISearchController
        
        init(representable: LocationSearch) {
            self.representable = representable
            self.searchController = UISearchController(searchResultsController: nil)
            super.init()
        }
    }
    
    class Wrapper: UIViewController {
        var searchController: UISearchController? {
            get {
                self.parent?.navigationItem.searchController
            }
            set {
                self.parent?.navigationItem.searchController = newValue
            }
        }
    }
}
