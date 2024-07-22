//
//  Rook.swift
//  shahmati
//
//  Created by Valery Dubovoy on 02.08.2023.
//

import Foundation

class Rook: LongRangeFigure, RookProtocol {
    static let figureName = "rook"
    
    override func getAssetName() -> String {
        Rook.figureName + "_" + color.rawValue
    }
    
    override func getMoveShifts() -> Set<CoordinateShift> {
        self.getRookShifts()
    }
    
}
