//
//  pawn.swift
//  shahmati
//
//  Created by Valery Dubovoy on 02.08.2023.
//

import Foundation

class Pawn: Figure {
    static let figureName = "pawn"
    
    override func getAssetName() -> String {
        Pawn.figureName + "_" + color.rawValue
    }
    
    override func getMoveShifts() -> Set<CoordinateShift> {
        var coordinateShifts: Set<CoordinateShift> = []
        if color == .white {
            coordinateShifts.insert(CoordinateShift(dx: 0, dy: 1))
            coordinateShifts.insert(CoordinateShift(dx: 1, dy: 1))
            coordinateShifts.insert(CoordinateShift(dx: -1, dy: 1))
            if coordinate.y == 2 {
                coordinateShifts.insert(CoordinateShift(dx: 0, dy: 2))
            }
        } else {
            coordinateShifts.insert(CoordinateShift(dx: 0, dy: -1))
            coordinateShifts.insert(CoordinateShift(dx: 1, dy: -1))
            coordinateShifts.insert(CoordinateShift(dx: -1, dy: -1))
            if coordinate.y == 7 {
                coordinateShifts.insert(CoordinateShift(dx: 0, dy: -2))
            }
        }
        return coordinateShifts
    }
    
    override func isSquareAvailableForMove(_ board: Board, coordinate: Coordinate) -> Bool {
        if board.willShahAfterMoveBe(from: self.coordinate, to: coordinate, color: self.color) {
            return false
        }
        if coordinate.x == self.coordinate.x{
            return board.isSquareEmpty(at: coordinate) && !board.hasFiguresBetween(coordinate1: self.coordinate, coordinate2: coordinate)
        }
        return !board.isSquareEmpty(at: coordinate) && board.getFigure(at: coordinate)!.color != self.color
    }
    
    override func isSquareAvailableForAttack(_ board: Board, coordinate: Coordinate) -> Bool {
        return self.coordinate.x != coordinate.x
    }
    
}
