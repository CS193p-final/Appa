//
//  AchievementView.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/6/21.
//

import SwiftUI

struct AchievementView: View {
    @EnvironmentObject var user: Person
    var body: some View {


        Text("You have visited \(user.placesVisited.count) places")
        if (user.placesVisited.count == 0) {
            Image(systemName: "tortoise.fill").imageScale(.large)
        } else {
            Image(systemName: "hare.fill").imageScale(.large)
        }
    }
}

struct AchievementView_Previews: PreviewProvider {
    static var user = Person(name: "Last First", placesVisited: [Place]())
    static var previews: some View {
        AchievementView().environmentObject(user)
    }
}
