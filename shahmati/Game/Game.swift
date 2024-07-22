//
//  Game.swift
//  shahmati
//
//  Created by Valery Dubovoy on 07.08.2023.
//

import Foundation

class Game: ObservableObject {
    @Published var currentColor: Figure.Color = .white
    @Published var board: Board
    @Published var selectedFigure: Figure? = nil
    @Published var availableMoves: Set<Coordinate> = []
    @Published var winner: Figure.Color? = nil
    @Published var gameIsEnded: Bool = false
    @Published var pawnIsGonnaChange: Bool = false
    
    init() {
        self.board = Board(
//            "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
//            "rnbqkbnr/pppp1ppp/8/8/1p1R4/8/PPPPPPPP/1NBQKBNR w Kkq - 0 1"
//            "rnbqkbnr/pp1pppp1/3p3p/8/5B2/7P/PPPP1PP1/RN1QKBNR w KQkq - 0 1"
//            "rnbqkb1r/pp1p2pp/5p2/1p1Q4/2B1Kn2/1P1p2B1/P1PPPPPP/RN4NR w HAkq - 0 1"
//            "rn1bkbnr/1qP1ppp1/ppp4p/1P6/5B2/7P/1PpP2P1/RN1QKBNR w KQkq - 0 1"
            "rn1bkbnr/1qP1ppp1/ppp4p/1P6/5B2/7P/6P1/RN2KBNR w KQkq - 0 1"
            
        )
    }
    
    func squareTapped(at coordinate: Coordinate) {
        if selectedFigure == nil || checkForReSelect(at: coordinate) {
            selectFigure(at: coordinate)
            return
        }
        
        if !availableMoves.contains(coordinate){
            return
        }
        board.makeMove(from: selectedFigure!.coordinate, to: coordinate)
        
        if coordinate.y == 1 || coordinate.y == 8 {
            if selectedFigure! is Pawn {
                pawnIsGonnaChange = true
                board.changingPawn = selectedFigure!
            }
        }
        
        currentColor = currentColor.makeOposite()
        if gameOver(for: currentColor) {
            gameIsEnded = true
        }
        selectedFigure = nil
        availableMoves = []
    }
    
    private func selectFigure(at coordinate: Coordinate) {
        guard let figure = board.getFigure(at: coordinate), figure.color == currentColor, board.changingPawn == nil else {
            return
        }
        
        selectedFigure = figure
        print(figure.moveWasMade)
        availableMoves = figure.getAvailableForMoveCoordinates(board)
    }
    
    private func checkForReSelect(at coordinate: Coordinate) -> Bool{
        guard selectedFigure != nil, let figure = board.getFigure(at: coordinate), figure.color == currentColor else {
            return false
        }
        
        return true
    }
    
    func changePawnIntoFigure(_ figureType: String) {
        board.changePawnIntoFigure(figureType)
        pawnIsGonnaChange = false
    }
    
    func gameOver(for color: Figure.Color) -> Bool{
        
        let figures = board.getFigures(of: color)
        for figure in figures {
            if !figure.getAvailableForMoveCoordinates(board).isEmpty {
                return false
            }
        }
        if board.shahMoment(to: color) {
            winner = color.makeOposite()
        }
        return true
    }
}
