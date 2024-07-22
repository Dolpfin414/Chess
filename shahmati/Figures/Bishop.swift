//
//  Bishop.swift
//  shahmati
//
//  Created by Valery Dubovoy on 02.08.2023.
//

import Foundation

class Bishop: LongRangeFigure, BishopProtocol {
    static let figureName = "bishop"
    
    override func getAssetName() -> String {
        Bishop.figureName + "_" + color.rawValue
    }
    
    override func getMoveShifts() -> Set<CoordinateShift> {
        self.getBishopShifts()
    }
    
    
    
}
