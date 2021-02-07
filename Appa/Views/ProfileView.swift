//
//  ProfileView.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/6/21.
//

import SwiftUI

struct ProfileView: View {
    @State var user: Person
    @State private var showImageSourceChooser = false
    @State private var isRenaming = false
    
    var body: some View {
        VStack {
            Text("Profile")
                .font(.system(size: profileFont))
            CircleImage(image: user.pfp).font(.system(size: pfpSize)).frame(width: pfpSize, height: pfpSize, alignment: .center)
                .onTapGesture {
                    showImageSourceChooser = true
                }
                .popover(isPresented: $showImageSourceChooser, content: {
                    ImageSourceChooser(showImageSourceChooser: $showImageSourceChooser, user: $user)
                })
            HStack {
                EditableText(user.firstName, isEditing: isRenaming) { name in
                    user.renameFirstname(to: name)
                }
                .frame(maxWidth: 200)

                EditableText(user.lastName, isEditing: isRenaming) { name in
                    user.renameLastname(to: name)
                }
                .frame(maxWidth: 100)

                Image(systemName: "pencil")
                    .onTapGesture {
                        isRenaming = true
                    }
            }
            .font(.system(size: profileFont))
            Spacer()
        }

    }
    
    var pfpSize: CGFloat = 150
    var profileFont: CGFloat = 40
    var nameFont: CGFloat = 15
}

struct ProfileView_Previews:
    PreviewProvider {
    static var user = Person(firstName: "First", lastName: "Last")
    static var previews: some View {
        ProfileView(user: user)
    }
}

struct ImageSourceChooser: View {
    @Binding var showImageSourceChooser: Bool
    @State private var imageSourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var showImagePicker = false
    @Binding var user: Person
    
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
        }
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(currentImage: user.pfp, sourceType: imageSourceType) {
                image in
                    user.changePfp(newPfp: image)
                }
            })
    }
}
