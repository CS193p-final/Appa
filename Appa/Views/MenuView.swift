//
//  MenuView.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/6/21.
//

import SwiftUI

struct MenuView: View {
    var user = Person(firstName: "First", lastName: "Last")
    var body: some View {
        VStack {
            NavigationView {
                List(){
                    NavigationLink(
                        destination: ProfileView(user: user),
                        label: {
                            Text("Profile")
                        })
                    NavigationLink(
                        destination: AchievementView(),
                        label: {
                            Text("Achievement")
                        })
                    NavigationLink(
                        destination: MemoryView(),
                        label: {
                            Text("Memory")
                        })
                    NavigationLink(
                        destination: SettingsView(),
                        label: {
                            Text("Settings")
                        })

                }
                .navigationTitle(Text("Menu"))
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
