//
//  SearchBar.swift
//  Appa
//
//  Created by Duong Pham on 2/5/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    @State private var isEditing = false
    
    var body: some View {
        ZStack {
            TextField("Search...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    isEditing = true
                }
            HStack {
                Spacer()
                if isEditing {
                    Button {
                        isEditing = false
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                    .frame(alignment: .bottomTrailing)
                }
            }
        }
    }
}
