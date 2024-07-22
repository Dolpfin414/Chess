//
//  PawnChoosingView.swift
//  shahmati
//
//  Created by Valery Dubovoy on 30.08.2023.
//

import SwiftUI

struct PawnChoosingView: View {
    let color: Figure.Color
    @EnvironmentObject var game: Game
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(.blue)
//                .border(.black, width: 2)
                .aspectRatio(2, contentMode: .fit)
            HStack{
                makeFiguresForChoosingView("knight")
                makeFiguresForChoosingView("bishop")
                makeFiguresForChoosingView("rook")
                makeFiguresForChoosingView("queen")
            }
        }
    }
    
    func makeFiguresForChoosingView(_ figure: String) -> some View {
        ZStack {
            let assetName = figure.lowercased() + "_" + color.rawValue
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .aspectRatio(1.0, contentMode: .fit)
                .background(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2))
                .padding(2)
            Image(assetName)
                .resizable()
                .scaledToFit()
        }
        .onTapGesture {
            game.changePawnIntoFigure(figure)
        }
    }
    
}

struct PawnChoosingView_Previews: PreviewProvider {
    static var previews: some View {
        PawnChoosingView(color: .white)
    }
}
