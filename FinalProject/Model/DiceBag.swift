//
//  DiceBag.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 10/2/20.
//

import Foundation


class DiceBag{
    //MARK: - Dice Declarations
    public static var diceD4 = Dice(sides: 4, diceName: "D4")
    public static var diceD6 = Dice(sides: 6, diceName: "D6")
    public static var diceD8 = Dice(sides: 8, diceName: "D8")
    public static var diceD10 = Dice(sides: 10, diceName: "D10")
    public static var diceD12 = Dice(sides: 12, diceName: "D12")
    public static var diceD20 = Dice(sides: 20, diceName: "D20")
    
    
    //MARK: - Dice Inventory
    public static var DiceBag = [Dice]()
}
