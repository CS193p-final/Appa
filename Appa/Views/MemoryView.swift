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
    @EnvironmentObject var user: Person
    @State private var showImageSourceChooser = false
    var body: some View {
        VStack {
            Button {
                user.addPlace(place: Place(name: "Hanoi", coordinate: CLLocationCoordinate2D(latitude: 21.0278, longitude: 105.8342)))
            } label: {
                Text("Add place")
            }
            List {
                ForEach(user.placesVisited) { place in
                    Text(place.name)
                    Image(systemName: "plus")
                        .onTapGesture {
                            showImageSourceChooser = true
                        }
                        .popover(isPresented: $showImageSourceChooser, content: {
                            MemoryImageSourceChooser(showImageSourceChooser: $showImageSourceChooser, place: user.placesVisited[user.placesVisited.firstIndex(matching: place)!])
                        })
                    Grid(place.photos, id: \.self) { photo in
                        Image(uiImage: photo)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
            }
        }
    }
}

struct MemoryImageSourceChooser: View {
    @Binding var showImageSourceChooser: Bool
    @State private var imageSourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var showImagePicker = false
    @EnvironmentObject var user: Person
    @State var place: Place

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
                        user.placesVisited[user.placesVisited.firstIndex(matching: place)!].addImage(image: image)
                    }
                }
            )
        }
    }
}

struct MemoryView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryView()
    }
}
