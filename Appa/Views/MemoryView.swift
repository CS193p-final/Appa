//
//  MemoryView.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/6/21.
//

import SwiftUI
import UIKit
import MapKit

struct MemoryView: View {
    @State var placesVisited: [Place]
    @State private var showImageSourceChooser = false
    var body: some View {
        List {
            ForEach(placesVisited) { place in
                Text(place.name)
                Image(systemName: "plus")
                    .onTapGesture {
                        showImageSourceChooser = true
                    }
                    .popover(isPresented: $showImageSourceChooser, content: {
                        ImageSourcePicker(showImageSourceChooser: $showImageSourceChooser, place: placesVisited[placesVisited.firstIndex(matching: place)!])
                    })
                if place.photos != nil {
                    Grid(place.photos!, id: \.self) { photo in
                        Image(uiImage: photo)
                    }
                }
            }
        }
    }
}

struct ImageSourcePicker: View {
    @Binding var showImageSourceChooser: Bool
    @State private var imageSourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var showImagePicker = false
    @ObservedObject var place: Place
    
    var body: some View {
        Text("Add photo to \(place.name)").font(.headline)
        Divider()
        HStack {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                Image(systemName: "camera").imageScale(.large)
                    .onTapGesture {
                        showImagePicker = true
                        imageSourceType = .camera
                    }
                }
            Image(systemName: "photo").imageScale(.large)
                .onTapGesture {
                    showImagePicker = true
                    imageSourceType = .photoLibrary
                }
                .popover(isPresented: $showImagePicker, content: {
                    ImagePicker(sourceType: imageSourceType) {
                        image in
                        place.addImage(image: image)
                    }
                }
            )
        }
    }
}

struct MemoryView_Previews: PreviewProvider {
    static var hanoi = Place(name: "Hanoi", coordinate: CLLocationCoordinate2D.init(latitude: 21.0278, longitude: 105.8342))
    static var placesVisit = [hanoi]
    static var previews: some View {
        MemoryView(placesVisited: placesVisit)
    }
}
