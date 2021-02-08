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
    let currentCoordinate: CLLocationCoordinate2D?
    @Binding var selection: MKAnnotation?
//    let annotations: [MKAnnotation]
    
    func makeUIView(context: Context) -> MKMapView {
        let mkMapView = MKMapView()
        mkMapView.delegate = context.coordinator
        mkMapView.showsUserLocation = true
        return mkMapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let coordinate = currentCoordinate {
            let town = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            uiView.setRegion(MKCoordinateRegion(center: coordinate, span: town), animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(selection: $selection)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        @Binding var selection: MKAnnotation?

        init(selection: Binding<MKAnnotation?>) {
            _selection = selection
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: "MapViewAnnotation") ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: "MapViewAnnotation")
            view.canShowCallout = true
            return view
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotation = view.annotation {
                selection = annotation
            }
        }
    }
}
