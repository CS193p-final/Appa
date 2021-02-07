//
//  CircleImage.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/5/21.
//

import SwiftUI

struct CircleImage: View {
    var image: UIImage
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .clipShape(Circle()).cornerRadius(4)
            .overlay(Circle().stroke(lineWidth: 4.0)
                .foregroundColor(.white)
                .shadow(radius: 7))
    }
}

//struct CircleImage_Previews: PreviewProvider {
//    static var previews: some View {
//        CircleImage()
//    }
//}
