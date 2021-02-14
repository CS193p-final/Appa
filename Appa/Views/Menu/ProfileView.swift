//
//  ProfileView.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/6/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var user: Person
    @State private var showImageSourceChooser = false
    @State private var isRenaming = false
    @State private var name: String = ""
    
    var body: some View {
        VStack {
            Text("Profile")
                .font(.system(size: profileFont))
            CircleImage(image: user.pfp).font(.system(size: pfpSize)).frame(width: pfpSize, height: pfpSize, alignment: .center)
                .onTapGesture {
                    showImageSourceChooser = true
                }
                .popover(isPresented: $showImageSourceChooser, content: {
                    ProfileImageSourceChooser(showImageSourceChooser: $showImageSourceChooser).environmentObject(user)
                })

            TextField("Name", text: $name, onEditingChanged: { began in
                if !began {
                    user.rename(to: name)
                }
            })
            .font(.system(size: nameFont))
            Spacer()
        }

    }
    
    var pfpSize: CGFloat = 150
    var profileFont: CGFloat = 40
    var nameFont: CGFloat = 20
}

struct ProfileView_Previews:
    PreviewProvider {
    static var user = Person(name: "last first", placesVisited: [Place]())
    static var previews: some View {
        ProfileView().environmentObject(user)
    }
}

struct ProfileImageSourceChooser: View {
    @Binding var showImageSourceChooser: Bool
    @State private var imageSourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var showImagePicker = false
    @EnvironmentObject var user: Person
    
    var body: some View {
        Text("Change Profile Photo").font(.headline)
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
                .popover(isPresented: $showImagePicker, content: { ImagePicker(sourceType: imageSourceType) { image in
                    user.changePfp(newPfp: image)
                        }
                    }
                )
            }
    }
}
