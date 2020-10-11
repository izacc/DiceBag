//
//  Dice.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 10/2/20.
//

import Foundation


class Dice: Equatable{
    static func == (lhs: Dice, rhs: Dice) -> Bool {
        return lhs.sides == rhs.sides && lhs.diceName == rhs.diceName
    }
    
    public var sides : Int = 0
    public var diceName : String
    
    
    init(sides: Int, diceName: String) {
        self.sides = sides
        self.diceName = diceName
    }
    
}
