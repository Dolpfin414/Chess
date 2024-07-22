//
//  LongRangeFigures.swift
//  shahmati
//
//  Created by Valery Dubovoy on 15.08.2023.
//

import Foundation

class LongRangeFigure: Figure {
    override func isSquareAvailableForMove(_ board: Board, coordinate: Coordinate) -> Bool {
 
        if !super.isSquareAvailableForMove(board, coordinate: coordinate) {
            return false
        }
        
        return !board.hasFiguresBetween(coordinate1: self.coordinate, coordinate2: coordinate)
    }
    
    override func isSquareAvailableForAttack(_ board: Board, coordinate: Coordinate) -> Bool {
        return !board.hasFiguresBetween(coordinate1: self.coordinate, coordinate2: coordinate)
    }
    
}
