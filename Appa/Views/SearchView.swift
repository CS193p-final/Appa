//
//  SearchView.swift
//  Appa
//
//  Created by Duong Pham on 2/5/21.
//

import SwiftUI

struct SearchView: View {
    @Binding var text: String
    var action: () -> ()
        
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").imageScale(.large)
            TextField("Search Here", text: $text, onCommit:  {
                action()
            })
        }
    }
}
