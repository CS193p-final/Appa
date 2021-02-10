//
//  SearchView.swift
//  Appa
//
//  Created by Duong Pham on 2/5/21.
//

import SwiftUI

struct SearchView: View {
    @State var text: String = ""
    
    //@State private var isEditing = false
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").imageScale(.large)
            TextField("Search Here", text: $text, onEditingChanged: { began in
                if !began {
                }
            })
        }
        .padding(7)
        .padding(.horizontal, 25)
        .background(Color(.systemGray))
        .cornerRadius(8)
        .padding(.horizontal, 10)
    }
}
