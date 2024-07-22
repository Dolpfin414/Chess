//
//  BoardSquareView.swift
//  shahmati
//
//  Created by Valery Dubovoy on 14.08.2023.
//

import SwiftUI

struct BoardSquareView: View {
    @EnvironmentObject var game: Game
    
    let x: Int
    let y: Int
    let figure: Figure?
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill((x + y) % 2 == 0 ? Color(white: 0.4) : Color(white: 0.8))
            if game.availableMoves.contains(Coordinate(x: x, y: y)) {
                Color.blue
                    .opacity(0.5)
                    .padding(2)
            }
            if let selctedFigure = game.selectedFigure, selctedFigure.coordinate == Coordinate(x: x, y: y) {
                Color.green
                    .opacity(0.5)
                    .padding(2)
            }
            if figure != nil && figure is King && game.board.shahMoment(to: figure!.color) {
                Color.red
                    .opacity(0.5)
                    .padding(2)
            }
            if figure != nil {
                Image(figure!.getAssetName())
                    .resizable()
                    .padding(4)
            }
            if x == 1 {
                topLeftNumber(y)
            }
            if y == 1 {
                bottomRightNumber(x)
            }
        }
        .frame(width: getDeviceBounds().width/8, height: getDeviceBounds().width/8)
        .foregroundColor(Color.black)
    }
    
    func topLeftNumber(_ number: Int) -> some View {
        HStack {
            VStack {
                Text("\(number)")
                    .scaleEffect(0.85)
                    .padding(.horizontal, 2)
                Spacer()
            }
            Spacer()
        }
    }
    func bottomRightNumber(_ number: Int) -> some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Text("\(number)")
                    .scaleEffect(0.85)
                    .padding(.horizontal, 2)
            }
        }
        
    }
}

struct BoardSquareView_Previews: PreviewProvider {
    static var previews: some View {
        BoardSquareView(x: 1, y: 1, figure: Rook(coordinate: Coordinate(x: 1, y: 1), color: .white))
            .environmentObject(Game())
    }
}
