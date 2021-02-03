//
//  MapView.swift
//  Appa
//
//  Created by Duong Pham on 2/2/21.
//

import SwiftUI
import UIKit
import MapKit

struct MapView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> MKMapView {
        let mkMapView = MKMapView()
        return mkMapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
}
