//
//  Figure.swift
//  shahmati
//
//  Created by Valery Dubovoy on 02.08.2023.
//

import Foundation
import SwiftUI

class Figure {
    var coordinate: Coordinate
    let color: Figure.Color
    var moveWasMade: Bool = false
    
    func getAssetName() -> String {
        "Unknown"
    }
    
    func getAvailableForMoveCoordinates(_ board: Board) -> Set<Coordinate> {
        var output: Set<Coordinate> = []
        let shifts = self.getMoveShifts()
        for shift in shifts {
            let coordinate = self.coordinate.from(shift: shift)
            if !coordinate.isValid {
                continue
            }
            if isSquareAvailableForMove(board, coordinate: coordinate) {
                output.insert(coordinate)
            }
        }
        
        return output
    }
    
    func getMoveShifts() -> Set<CoordinateShift> {
        []
    }
    
    func isSquareAvailableForMove(_ board: Board, coordinate: Coordinate) -> Bool {
        if !board.isSquareEmpty(at: coordinate) && board.getFigure(at: coordinate)!.color == self.color {
            return false
        }
        
        return !board.willShahAfterMoveBe(from: self.coordinate, to: coordinate, color: self.color)
    }
    
    func getAvailableForAttackCoordinates(_ board: Board) -> Set<Coordinate> {
        var output: Set<Coordinate> = []
        let shifts = self.getMoveShifts()
        for shift in shifts {
            let coordinate = self.coordinate.from(shift: shift)
            if !coordinate.isValid {
                continue
            }
            if isSquareAvailableForAttack(board, coordinate: coordinate) {
                output.insert(coordinate)
            }
        }

        return output
    }
    
    func isSquareAvailableForAttack(_ board: Board, coordinate: Coordinate) -> Bool {
        true
    }
    
    init(coordinate: Coordinate, color: Color) {
        self.coordinate = coordinate
        self.color = color
    }
}

extension Figure {
    enum Color: String {
        case white, black
        
        func makeOposite() -> Figure.Color {
            self == .white ? .black : .white
        }
    }
}
