//
//  MainNavigationView.swift
//  shahmati
//
//  Created by Valery Dubovoy on 29.08.2023.
//

import SwiftUI

struct MainNavigationView: View {
    @Binding var selectedTab: String
    
    var body: some View {
        switch selectedTab {
        case "menu":
            MenuView(selectedTab: $selectedTab)
        case "game":
            GameView(selectedTab: $selectedTab)
        case "settings":
            SettingsView(selectedTab: $selectedTab)
        default:
            MenuView(selectedTab: $selectedTab)
        }
    }
}

struct MainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigationView(selectedTab: .constant("menu"))
    }
}
