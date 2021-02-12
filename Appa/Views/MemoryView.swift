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
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        VStack {
            Button {
                user.addPlace(place: Place(name: "Hanoi", coordinate: CLLocationCoordinate2D(latitude: 21.0278, longitude: 105.8342)))
            } label: {
                Text("Add place")
            }
            List {
                VStack {
                    ForEach(user.placesVisited) { place in
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
                            }
                            .frame(height: 400)
                        }
                        .popover(isPresented: $showImageSourceChooser, content: {
                            MemoryImageSourceChooser(showImageSourceChooser: $showImageSourceChooser, place: place)
                        })
                    }
                }
            }
        }
    }
    
    var photoHeight: CGFloat {
        CGFloat((user.placesVisited.count - 1) / 6) * 70 + 70
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

struct MemoryView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryView()
    }
}
