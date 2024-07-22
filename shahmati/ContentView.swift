//
//  ContentView.swift
//  shahmati
//
//  Created by Valery Dubovoy on 01.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab: String = "menu"
    
    var body: some View {
        MainNavigationView(selectedTab: $selectedTab)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
