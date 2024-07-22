//
//  Queen.swift
//  shahmati
//
//  Created by Valery Dubovoy on 02.08.2023.
//

import Foundation

class Queen: LongRangeFigure, RookProtocol, BishopProtocol {
    static let figureName = "queen"
    
    override func getAssetName() -> String {
        Queen.figureName + "_" + color.rawValue
    }
    
    override func getMoveShifts() -> Set<CoordinateShift> {
        return self.getBishopShifts().union(self.getRookShifts())
    }
    
}
