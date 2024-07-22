//
//  GameOverView.swift
//  shahmati
//
//  Created by Valery Dubovoy on 29.08.2023.
//

import SwiftUI

struct GameOverView: View {
    @StateObject var game: Game = Game()
    @Binding var selectedTab: String
    
    var body: some View {
        VStack{
            Text("Game Over")
                .font(.largeTitle)
                .padding(.vertical, 10)
            if let winner = game.winner?.rawValue.capitalized {
                Text("\(winner) won!")
                    .font(.title)
            } else {
                Text("Draw")
                    .font(.title)
            }
        }
        .onTapGesture {
            selectedTab = "menu"
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(selectedTab: .constant("game"))
    }
}
