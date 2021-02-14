//
//  SearchBarAndMenuView.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/13/21.
//

import SwiftUI

struct SearchBarAndMenuView: View {
    @State private var showSearchView = false
    @State private var showMenu = false
    @Binding var searchString: String
    var action: () -> ()
    
    var body: some View {
        HStack {
            menuIcon.padding(.leading)
            SearchView(text: $searchString, action: action)
            .onTapGesture {
                showSearchView = true
            }
        }
        .padding(7)
        .background(Color(.systemGray))
        .cornerRadius(8)
        .padding(.horizontal, 10)
    }
    
    private var menuIcon: some View {
        Image(systemName: "menubar.rectangle")
            .imageScale(.large)
            .onTapGesture {
                showMenu = true
            }
            .sheet(isPresented: $showMenu, content: {
                MenuView()
            }
        )
    }
}
//
//struct SearchBarAndMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBarAndMenuView()
//    }
//}
