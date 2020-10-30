//
//  DiceBag.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 10/2/20.
//

import Foundation


class DiceBag{
    //MARK: - Dice Declarations
    public static var diceD4 = Dice(sides: 4, diceName: "d4")
    public static var diceD6 = Dice(sides: 6, diceName: "d6")
    public static var diceD8 = Dice(sides: 8, diceName: "d8")
    public static var diceD10 = Dice(sides: 10, diceName: "d10")
    public static var diceD12 = Dice(sides: 12, diceName: "d12")
    public static var diceD20 = Dice(sides: 20, diceName: "d20")
    
    
    //MARK: - Dice Inventory
    public static var DiceBag = [Dice]()
}
