//
//  SearchBar.swift
//  Appa
//
//  Created by Duong Pham on 2/5/21.
//

import SwiftUI

struct SearchBar: View {
    @State var text: String = ""
    
    //@State private var isEditing = false
    
    var body: some View {
        ZStack {
            TextField("Search...", text: $text, onEditingChanged: { began in
                if !began {
                }
            })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray))
                .cornerRadius(8)
                .padding(.horizontal, 10)
        }
    }
}
