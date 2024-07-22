//
//  MenuView.swift
//  shahmati
//
//  Created by Valery Dubovoy on 29.08.2023.
//

import SwiftUI

struct MenuView: View {
    @Binding var selectedTab: String
    
    var body: some View {
        VStack{
            Button (
                action: {
                    selectedTab = "game"
                }, label: {
                    Text("Play")
                        .font(.title)
                        .foregroundColor(.black)
                }
            )
            Button (
                action: {
                    selectedTab = "settings"
                }, label: {
                    Text("Settings")
                        .font(.title)
                        .foregroundColor(.black)
                }
            )
        }
    }
    
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(selectedTab: .constant("menu"))
    }
}
