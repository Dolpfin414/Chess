//
//  Knight.swift
//  shahmati
//
//  Created by Valery Dubovoy on 02.08.2023.
//

import Foundation

class Knight: Figure {
    static let figureName = "knight"
    
    override func getAssetName() -> String {
        Knight.figureName + "_" + color.rawValue
    }
    
    override func getMoveShifts() -> Set<CoordinateShift> {
        return [
            CoordinateShift(dx: 2, dy: 1),
            CoordinateShift(dx: 2, dy: -1),
            CoordinateShift(dx: -2, dy: 1),
            CoordinateShift(dx: -2, dy: -1),
            CoordinateShift(dx: 1, dy: 2),
            CoordinateShift(dx: 1, dy: -2),
            CoordinateShift(dx: -1, dy: 2),
            CoordinateShift(dx: -1, dy: -2)
        ]
    }
    
}
