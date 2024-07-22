//
//  RookProtocol.swift
//  shahmati
//
//  Created by Valery Dubovoy on 14.08.2023.
//

import Foundation

protocol RookProtocol {
    func getRookShifts() -> Set<CoordinateShift>
}

extension RookProtocol {
    func getRookShifts() -> Set<CoordinateShift> {
        var coordinateShift: Set<CoordinateShift> = []
        
        for i in 1...7 {
            coordinateShift.insert(CoordinateShift(dx: i, dy: 0))
            coordinateShift.insert(CoordinateShift(dx: -i, dy: 0))
            coordinateShift.insert(CoordinateShift(dx: 0, dy: i))
            coordinateShift.insert(CoordinateShift(dx: 0, dy: -i))
        }
        
        return coordinateShift
    }
}
