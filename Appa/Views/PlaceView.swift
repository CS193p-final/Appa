//
//  PlaceView.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/13/21.
//

import SwiftUI
import UIKit
import MapKit

struct PlaceView: View {
    
    @Binding var place: Place
    @State var showImageSourceChooser = false
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            Text(place.name)
            Image(systemName: "plus")
                .onTapGesture {
                    showImageSourceChooser = true
                }

            Divider()
            GeometryReader { geometry in
                ScrollView{
                    LazyVGrid(columns: gridItemLayout, spacing: 3) {
                        ForEach(place.photos, id: \.self) { photo in
                            Image(uiImage: UIImage(data: Data(base64Encoded: photo!)!)!)
                                .resizable()
                                .frame(width: geometry.size.width / 3, height: geometry.size.height / 3)
                        }
                    }
                }
                .popover(isPresented: $showImageSourceChooser, content: {
                    MemoryImageSourceChooser(showImageSourceChooser: $showImageSourceChooser, place: place)
                })
            }
            .frame(height: 400)
        }
    }
}

struct MemoryImageSourceChooser: View {
    @Binding var showImageSourceChooser: Bool
    @State private var imageSourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var showImagePicker = false
    @EnvironmentObject var user: Person
    @State var place: Place
    @State var showAlertForDuplicatedImage = false

    var body: some View {
        Text("Add photo to \(place.name)").font(.headline)
        Divider()
        HStack {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                VStack {
                    Image(systemName: "camera").imageScale(.large)
                    Text("Import photo from camera")
                    }
                .onTapGesture {
                    showImagePicker = true
                    imageSourceType = .camera
                }
                Divider()
            }
            VStack {
                Image(systemName: "photo").imageScale(.large)
                Text("Import photo from gallery")
                }
            .onTapGesture {
                showImagePicker = true
                imageSourceType = .photoLibrary
            }
        }
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(sourceType: imageSourceType) {
                image in
                if place.photos.contains(image.toBase64(format: .png)) {
                    showAlertForDuplicatedImage = true
                } else {
                    place.photos = place.addImage(image: image)
                }
            }
            .alert(isPresented: $showAlertForDuplicatedImage) { () -> Alert in
                .init(title: Text("Image is already in gallery"), message: Text("Image will not be dupilicated"), dismissButton: .cancel())
            }
        }
    )}
}


struct PlaceView_Previews: PreviewProvider {
    @State static var hanoi = Place(name: "middle of nowhere", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    static var previews: some View {
        PlaceView(place: $hanoi)
    }
}
