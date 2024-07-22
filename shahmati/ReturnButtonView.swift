//
//  ReturnButtonView.swift
//  shahmati
//
//  Created by Valery Dubovoy on 05.09.2023.
//

import SwiftUI

struct ReturnButtonView: View {
    @Binding var selectedTab: String
    
    var body: some View {
        HStack {
            Button(action: {
                selectedTab = "menu"
            }, label: {
                Image(systemName: "chevron.backward")
                    .padding()
                Text("Menu")
                    .padding(.horizontal, -15)
                Spacer()
            })
        }
    }
}

struct ReturnButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ReturnButtonView(selectedTab: .constant("settings"))
    }
}
