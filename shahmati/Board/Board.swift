//
//  board.swift
//  shahmati
//
//  Created by Valery Dubovoy on 01.08.2023.
//

import Foundation

class Board: ObservableObject {
    @Published var figures: [Coordinate: Figure] = [:]
    
    var currentFen: String = ""
    var changingPawn: Figure? = nil
    
    init(_ fenString: String) {
        let rows = fenString.split(separator: " ")[0]
        let rowsInfo = rows.split(separator: "/")
        
        
        for (i, row) in rowsInfo.enumerated() {
            let y = 8 - i
            var x = 1
            
            for char in row {
                if char.isNumber {
                    x += Int(String(char))!
                    continue
                }
                let color: Figure.Color = char.isUppercase ? .white : .black
                
                switch(char.lowercased()) {
                case "p":
                    figures[Coordinate(x: x, y: y)] = Pawn(coordinate: Coordinate(x: x, y: y), color: color)
                case "r":
                    figures[Coordinate(x: x, y: y)] = Rook(coordinate: Coordinate(x: x, y: y), color: color)
                case "n":
                    figures[Coordinate(x: x, y: y)] = Knight(coordinate: Coordinate(x: x, y: y), color: color)
                case "b":
                    figures[Coordinate(x: x, y: y)] = Bishop(coordinate: Coordinate(x: x, y: y), color: color)
                case "q":
                    figures[Coordinate(x: x, y: y)] = Queen(coordinate: Coordinate(x: x, y: y), color: color)
                case "k":
                    figures[Coordinate(x: x, y: y)] = King(coordinate: Coordinate(x: x, y: y), color: color)
                default:
                    fatalError("Incorrect FEN notation!!!")
                }
                x += 1
            }
            currentFen = makeFen()
        }
        
        
    }
    
    func isSquareEmpty(at coordinate: Coordinate) -> Bool {
        figures[coordinate] == nil
    }
    
    func getFigure(at coordinate: Coordinate) -> Figure? {
        figures[coordinate]
    }
    
    func makeMove(from oldCoordinate: Coordinate, to newCoordinate: Coordinate) {
        if figures[oldCoordinate] is King && abs(newCoordinate.x - oldCoordinate.x) > 1 {
            makeRokirovka(figures[oldCoordinate]!, newCoordinate, oldCoordinate)
            return
        }
        
        figures[newCoordinate] = figures[oldCoordinate]
        figures[newCoordinate]?.coordinate = newCoordinate
        figures[oldCoordinate] = nil
        
        figures[newCoordinate]?.moveWasMade = true
        currentFen = makeFen()
    }
    
    func isMoveAvailable(from oldCoordinate: Coordinate, to newCoordinate: Coordinate) -> Bool {
        guard let figure = figures[oldCoordinate], figure.getAvailableForMoveCoordinates(self).contains(newCoordinate) else {
            return false
        }
        return true
    }
    
    func getFigures(of color: Figure.Color) -> [Figure] {
        figures.values.filter { figure in
            figure.color == color
        }
    }
    
    func makeFen() -> String {
        var fen = ""
        
        for y in (1...8).reversed() {
            var emptySquaresCount = 0
            for x in 1...8 {
                if isSquareEmpty(at: Coordinate(x: x, y: y)) {
                    emptySquaresCount += 1
                    continue
                }
                if emptySquaresCount > 0 {
                    fen += "\(emptySquaresCount)"
                    emptySquaresCount = 0
                }
                let figure = getFigure(at: Coordinate(x: x, y: y))
                
                switch figure {
                case is King:
                    fen += figure!.color == .white ? "K" : "k"
                case is Knight:
                    fen += figure!.color == .white ? "N" : "n"
                case is Bishop:
                    fen += figure!.color == .white ? "B" : "b"
                case is Rook:
                    fen += figure!.color == .white ? "R" : "r"
                case is Queen:
                    fen += figure!.color == .white ? "Q" : "q"
                case is Knight:
                    fen += figure!.color == .white ? "N" : "n"
                case is Pawn:
                    fen += figure!.color == .white ? "P" : "p"
                default:
                    continue
                }
                
            }
            if emptySquaresCount > 0 {
                fen += "\(emptySquaresCount)"
            }
            if y != 1 {
                fen += "/"
            }
        }
        return fen
    }
    
    func makeRokirovka(_ king: Figure, _ newCoordinate: Coordinate, _ initKingCoordinate: Coordinate) {
        if newCoordinate.x < initKingCoordinate.x {
            let rook = figures[Coordinate(x: 1, y: initKingCoordinate.y)]
            figures[rook!.coordinate] = nil
            figures[Coordinate(x: initKingCoordinate.x - 1, y: initKingCoordinate.y)] = rook
            rook!.coordinate = Coordinate(x: initKingCoordinate.x - 1, y: initKingCoordinate.y)
        } else {
            let rook = figures[Coordinate(x: 8, y: initKingCoordinate.y)]
            figures[rook!.coordinate] = nil
            figures[Coordinate(x: initKingCoordinate.x + 1, y: initKingCoordinate.y)] = rook
            rook!.coordinate = Coordinate(x: initKingCoordinate.x + 1, y: initKingCoordinate.y)
        }
        figures[newCoordinate] = king
        king.coordinate = newCoordinate
        
        figures[initKingCoordinate] = nil
        
        currentFen = makeFen()
    }
    
    func willShahAfterMoveBe(from oldCoordinate: Coordinate, to newCoordinate: Coordinate, color: Figure.Color) -> Bool {
        let possibleBoard = Board(currentFen)
        possibleBoard.makeMove(from: oldCoordinate, to: newCoordinate)
        
        return possibleBoard.shahMoment(to: color)
    }
    
    func shahMoment(to color: Figure.Color) -> Bool {
        let kingCoordinate = findKing(of: color)
        
        return isSquareUnderAttack(coordinate: kingCoordinate, color: color)
    }
    
    func findKing(of color: Figure.Color) -> Coordinate {
        for figure in getFigures(of: color) {
            if (figure is King) {
                return figure.coordinate
            }
        }
        return Coordinate(x: 0, y: 0)
    }
    
    func availableForRokirovkaRooks(of color: Figure.Color) -> [Figure] {
        var rooks: [Figure] = []
        for figure in getFigures(of: color) {
            if figure is Rook && !figure.moveWasMade {
                rooks.append(figure)
            }
        }
        return rooks
    }
    
    func changePawnIntoFigure(_ figureType: String) {
        figures[changingPawn!.coordinate] = getFigureFromName(changingPawn!.coordinate, figureType, changingPawn!.color)
        currentFen = makeFen()
        changingPawn = nil
    }
    
    func getFigureFromName(_ coordinate: Coordinate, _ name: String, _ color: Figure.Color) -> Figure {
        let figureName = name.lowercased()
        
        switch figureName {
        case "pawn":
            return Pawn(coordinate: coordinate, color: color)
        case "rook":
            return Rook(coordinate: coordinate, color: color)
        case "knight":
            return Knight(coordinate: coordinate, color: color)
        case "bishop":
            return Bishop(coordinate: coordinate, color: color)
        case "queen":
            return Queen(coordinate: coordinate, color: color)
        case "king":
            return King(coordinate: coordinate, color: color)
        default:
            fatalError()
        }
    }
    
    func isSquareUnderAttack(coordinate: Coordinate, color: Figure.Color) -> Bool {
        let enemyFigures = getFigures(of: color.makeOposite())
        for figure in enemyFigures {
            if figure.getAvailableForAttackCoordinates(self).contains(coordinate) {
                return true
            }
        }
        return false
    }
    
    static let example: Board = Board("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
}
