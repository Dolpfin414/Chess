//
//  BishopProtocol.swift
//  shahmati
//
//  Created by Valery Dubovoy on 14.08.2023.
//

import Foundation

protocol BishopProtocol {
    func getBishopShifts() -> Set<CoordinateShift>
}

extension BishopProtocol {
    func getBishopShifts() -> Set<CoordinateShift> {
        var coordinateShift: Set<CoordinateShift> = []
        
        for i in 1...7 {
            coordinateShift.insert(CoordinateShift(dx: i, dy: i))
            coordinateShift.insert(CoordinateShift(dx: -i, dy: -i))
            coordinateShift.insert(CoordinateShift(dx: -i, dy: i))
            coordinateShift.insert(CoordinateShift(dx: i, dy: -i))
        }
        
        return coordinateShift
    }
}
