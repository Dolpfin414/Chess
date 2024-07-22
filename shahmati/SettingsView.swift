//
//  Settings.swift
//  shahmati
//
//  Created by Valery Dubovoy on 29.08.2023.
//

import SwiftUI

struct SettingsView: View {
    @Binding var selectedTab: String
    
    var body: some View {
        ZStack {
            VStack {
                ReturnButtonView(selectedTab: $selectedTab)
                Text("Settings")
                    .font(.largeTitle)
                Spacer()
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedTab: .constant("settings"))
    }
}
