//
//  PlaceListView.swift
//  Appa
//
//  Created by Duong Pham on 2/11/21.
//

import SwiftUI
import MapKit

struct PlaceListView: View {
    
    let landmarks: [Landmark]
    var onTap: () -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                EmptyView()
            }
                .frame(width: UIScreen.main.bounds.size.width, height: 60)
                .background(Color.gray)
                .gesture(TapGesture().onEnded(self.onTap))
        
            
            List {
                ForEach(self.landmarks, id: \.id) { landmark in
                    VStack(alignment: .leading) {
                        Text(landmark.name)
                            .fontWeight(.bold)
                        Text(landmark.title)
                    }
                }
            }.animation(nil)
        }.cornerRadius(10)
    }
}
