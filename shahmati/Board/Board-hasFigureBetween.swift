//
//  Board-hasFigureBetween.swift
//  shahmati
//
//  Created by Valery Dubovoy on 17.08.2023.
//

import Foundation

extension Board {
    func hasFiguresBetween(coordinate1: Coordinate, coordinate2: Coordinate) -> Bool {
        
        if coordinate1.x == coordinate2.x {
            return hasFiguresBetweenVertically(y1: coordinate1.y, y2: coordinate2.y, x: coordinate1.x)
        }
        
        if coordinate1.y == coordinate2.y {
            return hasFiguresBetweenHorizontaly(x1: coordinate1.x, x2: coordinate2.x, y: coordinate1.y)
        }
        
        let dx = coordinate2.x - coordinate1.x
        let dy = coordinate2.y - coordinate1.y
        if abs(dx) == abs(dy) {
            return hasFiguresBetweenDiaganally(dx: dx, dy: dy, coordinate1: coordinate1, coordinate2: coordinate2)
        }
        
        return false
    }
    
    func hasFiguresBetweenVertically(y1: Int, y2: Int, x: Int) -> Bool {
        let (low, high) = (min(y1, y2), max(y1, y2))
        
        for i in (low + 1)..<high {
            if !isSquareEmpty(at: Coordinate(x: x, y: i)) {
                return true
            }
                
        }
        
        return false
    }
    
    func hasFiguresBetweenHorizontaly(x1: Int, x2: Int, y: Int) -> Bool {
        let (low, high) = (min(x1, x2), max(x1, x2))
        
        for i in (low + 1)..<high {
            if !isSquareEmpty(at: Coordinate(x: i, y: y)) {
                return true
            }
                
        }
    return false
    }
    
    func hasFiguresBetweenDiaganally(dx: Int, dy: Int, coordinate1: Coordinate, coordinate2: Coordinate) -> Bool {
        let dxOrientation = abs(dx)/dx
        let dyOrientation = abs(dy)/dy
        var currentPos = Coordinate(x: coordinate1.x + dxOrientation, y: coordinate1.y + dyOrientation)
        
        while currentPos != coordinate2 {
            if !isSquareEmpty(at: currentPos) {
                return true
            }
            currentPos = Coordinate(x: currentPos.x + dxOrientation, y: currentPos.y + dyOrientation)
        }
        
        return false
    }
}
