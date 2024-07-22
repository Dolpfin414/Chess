//
//  GameView.swift
//  shahmati
//
//  Created by Valery Dubovoy on 29.08.2023.
//

import SwiftUI

struct GameView: View {
    @StateObject var game: Game = Game()
    @Binding var selectedTab: String
    
    var body: some View {
        if game.gameIsEnded {
            GameOverView(game: game, selectedTab: $selectedTab)
                .environmentObject(game)
        } else {
            ZStack {
                BoardView(board: game.board)
                    .environmentObject(game)
                if game.pawnIsGonnaChange {
                    PawnChoosingView(color: game.board.changingPawn!.color)
                        .environmentObject(game)
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(selectedTab: .constant("game"))
    }
}
