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
    let landmarks: [Landmark]
    let currentCoordinate: CLLocationCoordinate2D?
    @Binding var selection: MKAnnotation?
    
    func makeUIView(context: Context) -> MKMapView {
        let mkMapView = MKMapView()
        mkMapView.delegate = context.coordinator
        mkMapView.showsUserLocation = true
        return mkMapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateAnnotations(from: uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(selection: $selection)
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = landmarks.map(LandmarkAnnotation.init)
        mapView.addAnnotations(annotations)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        @Binding var selection: MKAnnotation?

        init(selection: Binding<MKAnnotation?>) {
            _selection = selection
        }
        
        func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
            if let annotationView = views.first {
                if let annotation = annotationView.annotation {
                    if annotation is MKUserLocation {
                        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                        mapView.setRegion(region, animated: true)
                    }
                }
            }
        }
        
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            let view = mapView.dequeueReusableAnnotationView(withIdentifier: "MapViewAnnotation") ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: "MapViewAnnotation")
//            view.canShowCallout = true
//            return view
//        }
//
//        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//            if let annotation = view.annotation {
//                selection = annotation
//            }
//        }
    }
}
