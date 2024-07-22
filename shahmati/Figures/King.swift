//
//  King.swift
//  shahmati
//
//  Created by Valery Dubovoy on 02.08.2023.
//

import Foundation
import SwiftUI

class King: Figure {
    static let figureName = "king"
    
    override func getAssetName() -> String {
        King.figureName + "_" + color.rawValue
    }
    
    override func getMoveShifts() -> Set<CoordinateShift> {
        var coordinateShifts: Set<CoordinateShift> = []
        for i in -1...1 {
            for j in -1...1 {
                if i == 0 && j == 0 {
                    continue
                }
                coordinateShifts.insert(CoordinateShift(dx: i, dy: j))
            }
        }
        return coordinateShifts
    }
    
    override func getAvailableForMoveCoordinates(_ board: Board) -> Set<Coordinate> {
        var output = super.getAvailableForMoveCoordinates(board)
        
        if !moveWasMade {
            let availableForRokirovkaRooks = board.availableForRokirovkaRooks(of: self.color)
            if availableForRokirovkaRooks.isEmpty {
                return output
            }
            for rook in availableForRokirovkaRooks {
                if !board.hasFiguresBetween(coordinate1: self.coordinate, coordinate2: rook.coordinate) {
                    if rook.coordinate.x < self.coordinate.x {
                        if !board.isSquareUnderAttack(coordinate: Coordinate(x: self.coordinate.x - 1, y: self.coordinate.y), color: self.color) && !board.isSquareUnderAttack(coordinate: Coordinate(x: self.coordinate.x - 2, y: self.coordinate.y), color: self.color) {
                            output.insert(Coordinate(x: self.coordinate.x - 2, y: self.coordinate.y))
                        }
                    } else {
                        if !board.isSquareUnderAttack(coordinate: Coordinate(x: self.coordinate.x + 1, y: self.coordinate.y), color: self.color) && !board.isSquareUnderAttack(coordinate: Coordinate(x: self.coordinate.x + 2, y: self.coordinate.y), color: self.color) {
                            output.insert(Coordinate(x: self.coordinate.x + 2, y: self.coordinate.y))
                        }
                    }
                }
            }
        }
        
        return output
    }
}
