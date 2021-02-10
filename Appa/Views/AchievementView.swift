//
//  AchievementView.swift
//  Appa
//
//  Created by Giang Nguyenn on 2/6/21.
//

import SwiftUI

struct AchievementView: View {
    var user: Person
    var body: some View {
        Text("You have visited \(user.placesVisited.count) places")
    }
}

struct AchievementView_Previews: PreviewProvider {
    static var user = Person(firstName: "First", lastName: "Last")
    static var previews: some View {
        AchievementView(user: user)
    }
}
